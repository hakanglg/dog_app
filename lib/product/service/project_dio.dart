import 'package:dio/dio.dart';

class ProjectDioMixin {
  final Dio service = Dio(BaseOptions(baseUrl: "https://dog.ceo/api"));
}
