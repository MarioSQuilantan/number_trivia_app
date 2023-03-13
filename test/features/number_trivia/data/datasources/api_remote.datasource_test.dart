import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/error/exception.dart';
import 'package:number_trivia_app/core/network/http_client.dart';
import 'package:number_trivia_app/core/utils/json_reader.util.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/api_remote.datasource.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia.model.dart';
import 'package:http/http.dart' as http_client;

import '../../../../mocks.dart';

class FakeUri extends Fake implements Uri {}

void main() {
  late MockHttp http;
  late HttpClient httpClient;
  late ApiRemoteDataSourceImpl dataSource;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    http = MockHttp();
    httpClient = HttpClient(http);
    dataSource = ApiRemoteDataSourceImpl(httpClient);
  });

  final tJsonData = jsonReader('number_trivia');
  final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(tJsonData));

  group('getRandomNumberTrivia should', () {
    test('return a valid Number Trivia Model when the status code is 200', () async {
      when(
        () => http.get(any()),
      ).thenAnswer(
        (_) async => http_client.Response(tJsonData, 200),
      );

      final response = await dataSource.getRandomNumberTrivia();

      expect(response, tNumberTriviaModel);
    });

    test('return a ServerException when the status code is not 200', () async {
      when(() => http.get(any())).thenAnswer((_) async => http_client.Response('Not found', 404));

      final call = dataSource.getRandomNumberTrivia();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
