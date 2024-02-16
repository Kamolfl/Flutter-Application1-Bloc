import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/dogs_model.dart';

class GetDogRepository {
  GetDogRepository({required this.dio});
  final Dio dio;
  Future<DogsModel> getDogs() async {
    final Response response = await dio.get('https://dog.ceo/api/breeds/image/random');
    return DogsModel.fromJson(response.data);
  }
}