import 'dart:convert';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_client.dart';
import '../../../../core/values/constants.dart';
import '../models/number_trivia.model.dart';

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
