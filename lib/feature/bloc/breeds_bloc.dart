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
        _preferencesManager.setStringValue(
          PreferencesKey.BREEDS,
          breeds.map((breed) => breed.toJson()).toList().toString(),
        );
        emit(BreedsLoaded(breeds: allBreeds));
      } else {
        emit(BreedsError(message: 'No breeds found.'));
      }
    } catch (e) {
      emit(BreedsError(message: 'Failed to load breeds: ${e.toString()}'));
    }
  }

  void _onSearchBreeds(SearchBreeds event, Emitter<BreedsState> emit) {
    if (state is BreedsLoaded) {
      final currentState = state as BreedsLoaded;

      if (event.query.isEmpty) {
        // Arama metni boşsa, PreferencesManager'dan saklanan tüm listeyi geri yükleyin
        final savedBreeds = _preferencesManager.getStringValue(PreferencesKey.BREEDS);
        if (savedBreeds.isNotEmpty) {
          final List<Breed> breeds = (savedBreeds as List).map((breedJson) => Breed.fromJson(breedJson)).toList();
          emit(BreedsLoaded(breeds: breeds));
        } else {
          emit(BreedsError(message: 'No breeds found in preferences.'));
        }
      } else {
        // Arama metni varsa, filtreleme yaparak sonuçları yayınlayın
        final filteredBreeds = allBreeds.where((breed) {
          return breed.breed!.toLowerCase().contains(event.query.toLowerCase());
        }).toList();

        if (filteredBreeds.isEmpty) {
          emit(BreedsNoResults());
        } else {
          emit(BreedsLoaded(breeds: filteredBreeds));
        }
      }
    } else {
      emit(BreedsError(message: 'Breeds data is not loaded.'));
    }
  }


  // Future<void> _onLoadAllBreeds(LoadAllBreeds event, Emitter<BreedsState> emit) async {
  //   emit(BreedsLoading());
  //   try {
  //     final breeds = await dogRepository.fetchAllBreeds();
  //     if (breeds != null) {
  //       allBreeds = breeds;
  //       emit(BreedsLoaded(breeds: allBreeds));
  //     } else {
  //       emit(BreedsError(message: 'Failed to load breeds.'));
  //     }
  //   } catch (e) {
  //     emit(BreedsError(message: 'Error: ${e.toString()}'));
  //   }
  // }

  // void _onSearchBreeds(SearchBreeds event, Emitter<BreedsState> emit) {
  //   if (state is BreedsLoaded) {
  //     final currentState = state as BreedsLoaded;
  //
  //     // Arama sorgusuna göre filtreleme yapıyoruz
  //     final filteredBreeds = allBreeds.where((breed) {
  //       return breed.breed!.toLowerCase().contains(event.query.toLowerCase());
  //     }).toList();
  //
  //     if (filteredBreeds.isEmpty) {
  //       // Eğer arama sonucu boşsa
  //       emit(BreedsNoResults());
  //     } else {
  //       // Arama sonucu varsa yeni listeyi yayınla
  //       emit(BreedsLoaded(breeds: filteredBreeds));
  //     }
  //   }
  // }
}
