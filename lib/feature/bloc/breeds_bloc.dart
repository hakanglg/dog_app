import 'package:bloc/bloc.dart';
import 'package:dogapp/product/model/breed.dart';
import 'package:dogapp/product/repository/dog_repository.dart';
import 'package:dogapp/product/utility/preferences_manager.dart';
import 'package:equatable/equatable.dart';

part 'breeds_event.dart';
part 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  BreedsBloc({
    required this.dogRepository,
  }) : super(BreedsInitial()) {
    on<LoadAllBreeds>(_onLoadAllBreeds);
    on<SearchBreeds>(_onSearchBreeds);
  }

  final DogRepository dogRepository;
  final PreferencesManager preferencesManager = PreferencesManager.instance;
  List<Breed> _allBreeds = [];

  Future<void> _onLoadAllBreeds(LoadAllBreeds event, Emitter<BreedsState> emit) async {
    emit(BreedsLoading());
    try {
      final breeds = await _fetchBreeds();
      if (breeds.isNotEmpty) {
        _allBreeds = breeds;
        emit(BreedsLoaded(breeds: _allBreeds));
      } else {
        emit(BreedsError(message: 'No breeds found.'));
      }
    } catch (e) {
      emit(BreedsError(message: 'Failed to load breeds: $e'));
    }
  }

  Future<void> _onSearchBreeds(SearchBreeds event, Emitter<BreedsState> emit) async {
    if (event.query.isEmpty) {
      await _handleEmptyQuery(emit);
    } else {
      _handleNonEmptyQuery(event.query, emit);
    }
  }

  Future<void> _handleEmptyQuery(Emitter<BreedsState> emit) async {
    if (_allBreeds.isEmpty) {
      await _loadBreedsFromSourceOrPreferences(emit);
    } else {
      emit(BreedsLoaded(breeds: _allBreeds));
    }
  }

  void _handleNonEmptyQuery(String query, Emitter<BreedsState> emit) {
    if (_allBreeds.isEmpty) {
      emit(BreedsError(message: 'Breeds data is not loaded.'));
      return;
    }

    final filteredBreeds = _allBreeds.where((breed) =>
    breed.breed?.toLowerCase().contains(query.toLowerCase()) ?? false
    ).toList();

    emit(filteredBreeds.isEmpty ? BreedsNoResults() : BreedsLoaded(breeds: filteredBreeds));
  }

  Future<void> _loadBreedsFromSourceOrPreferences(Emitter<BreedsState> emit) async {
    emit(BreedsLoading());
    try {
      final breeds = await _fetchBreeds();
      if (breeds.isNotEmpty) {
        _allBreeds = breeds;
        emit(BreedsLoaded(breeds: breeds));
      } else {
        emit(BreedsError(message: 'No breeds found.'));
      }
    } catch (e) {
      emit(BreedsError(message: 'Failed to load breeds: $e'));
    }
  }

  Future<List<Breed>> _fetchBreeds() async {

    if (!preferencesManager.isInitialized) {
      final breeds = await dogRepository.fetchAllBreeds();
      if (breeds != null && breeds.isNotEmpty) {
        await preferencesManager.setBreeds(breeds);
        return breeds;
      }
    }


    if (preferencesManager.isInitialized) {
      final savedBreeds = preferencesManager.getBreeds();
      if (savedBreeds.isNotEmpty) {
        return savedBreeds;
      }
    }

    return [];
  }
}