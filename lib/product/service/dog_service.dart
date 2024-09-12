import 'package:dio/dio.dart';

abstract class IDogService {
  IDogService(
      this.dio,
      );

  final Dio dio;

  Future<Map<String, dynamic>?> fetchAllBreeds();
  Future<String?> fetchBreedImage(String breed);
}

enum _DogPath { breeds, breed }

class DogService extends IDogService {
  DogService(super.dio);

  @override
  Future<Map<String, dynamic>?> fetchAllBreeds() async {
    try {
      final response = await dio.get("/${_DogPath.breeds.name}/list/all");
      if (response.statusCode == 200) {
        return response.data['message'] as Map<String, dynamic>;
      } else {
        print('Failed to load breeds. Status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      return null;
    }
  }

  @override
  Future<String?> fetchBreedImage(String breed) async {
    try {
      var url = "/${_DogPath.breed.name}/$breed/images/random";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data['message'] as String; // Resim URL'si
      } else {
        print('Failed to load breed image. Status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      return null;
    }
  }
}