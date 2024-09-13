import 'package:dogapp/product/model/breed.dart';
import 'package:dogapp/product/service/dog_service.dart';

class DogRepository {
  final DogService _dogService;

  DogRepository(this._dogService);

  Future<List<Breed>?> fetchAllBreeds() async {
    final breedsData = await _dogService.fetchAllBreeds();
    if (breedsData != null) {
      return await _parseBreedsWithImages(breedsData);
    }
    return null;
  }

  Future<List<Breed>> _parseBreedsWithImages(Map<String, dynamic> breedsData) async {
    List<Breed> breeds = [];
    for (var breed in breedsData.keys) {
      var subBreeds = List<String>.from(breedsData[breed]);

      String? imageUrl = await _dogService.fetchBreedImage(breed);

      breeds.add(Breed(
        breed: breed,
        subBreeds: subBreeds,
        imageUrl: imageUrl,
      ));
    }
    return breeds;
  }

  Future<String?> fetchRandomBreedImage(String breed) async {
    return await _dogService.fetchBreedImage(breed);
  }
}
