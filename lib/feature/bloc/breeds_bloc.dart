import 'package:bloc/bloc.dart';
import 'package:dogapp/product/model/breed.dart';
import 'package:dogapp/product/repository/dog_repository.dart';
import 'package:dogapp/product/utility/preferences_manager.dart';
import 'package:equatable/equatable.dart';

part 'breeds_event.dart';
part 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  BreedsBloc({required this.dogRepository}) : super(BreedsInitial()) {
    on<LoadAllBreeds>(_onLoadAllBreeds);
    on<SearchBreeds>(_onSearchBreeds);
  }

  final DogRepository dogRepository;
  final PreferencesManager _preferencesManager = PreferencesManager.instance;
  List<Breed> allBreeds = [];

  Future<void> _onLoadAllBreeds(LoadAllBreeds event, Emitter<BreedsState> emit) async {
    emit(BreedsLoading());
    try {
      final breeds = await dogRepository.fetchAllBreeds();
      if (breeds != null && breeds.isNotEmpty) {
        allBreeds = breeds;
        await _preferencesManager.setBreeds(breeds);
        emit(BreedsLoaded(breeds: allBreeds));
      } else {
        emit(BreedsError(message: 'No breeds found.'));
      }
    } catch (e) {
      emit(BreedsError(message: 'Failed to load breeds: ${e.toString()}'));
    }
  }

  Future<void> _onSearchBreeds(SearchBreeds event, Emitter<BreedsState> emit) async {
    if (event.query.isEmpty) {
      if (!_preferencesManager.isInitialized) {
        emit(BreedsLoading());
        try {
          final breeds = await dogRepository.fetchAllBreeds();
          if (breeds != null && breeds.isNotEmpty) {
            allBreeds = breeds;
            await _preferencesManager.setBreeds(breeds);
            emit(BreedsLoaded(breeds: breeds));
          } else {
            emit(BreedsError(message: 'No breeds found.'));
          }
        } catch (e) {
          emit(BreedsError(message: 'Failed to load breeds: ${e.toString()}'));
        }
      } else {
        final savedBreeds = _preferencesManager.getBreeds();
        if (savedBreeds.isNotEmpty) {
          allBreeds = savedBreeds;
          emit(BreedsLoaded(breeds: savedBreeds));
        } else {
          emit(BreedsError(message: 'No breeds found in preferences.'));
        }
      }
    } else {
      if (allBreeds.isEmpty) {
        emit(BreedsError(message: 'Breeds data is not loaded.'));
        return;
      }
      final filteredBreeds = allBreeds.where((breed) {
        return breed.breed!.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      if (filteredBreeds.isEmpty) {
        emit(BreedsNoResults());
      } else {
        emit(BreedsLoaded(breeds: filteredBreeds));
      }
    }
  }
}