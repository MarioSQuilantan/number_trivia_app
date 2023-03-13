import 'dart:convert';

import 'package:number_trivia_app/core/error/exception.dart';
import 'package:number_trivia_app/core/values/constants.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia.model.dart';

import '../../../../core/network/network_client.dart';

abstract class ApiRemoteDataSource {
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class ApiRemoteDataSourceImpl extends ApiRemoteDataSource {
  final NetworkClient networkClient;

  ApiRemoteDataSourceImpl(this.networkClient);

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final response = await networkClient.get(ApiConstants.getRandomNumberTrivia);
    if (response.statusCode >= 200 && response.statusCode < 400) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
