import 'dart:io';

import 'package:dio/dio.dart';

abstract class IDogService {
  IDogService(
      this.dio,
      );

  final Dio dio;

  Future<Map<String, dynamic>?> fetchAllBreeds();
}

enum _DogPath { breeds }

class DogService extends IDogService {
  DogService(super.dio);

  @override
  Future<Map<String, dynamic>?> fetchAllBreeds() async {
    try {
      final response = await dio.get("/${_DogPath.breeds.name}/list/all");
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        print('Failed to load breeds. Status code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      return null;
    }
  }
}