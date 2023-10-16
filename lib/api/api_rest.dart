import 'package:dio/dio.dart';

class ApiRest {
  final Dio dio;
  static const DEFAULT_CONNECT_TIMEOUT = 30000;
  static const DEFAULT_RECEIVE_TIMEOUT = 15000;

  ApiRest(this.dio) {
    dio.options.baseUrl = 'https://swapi.dev/api';
  }
}
