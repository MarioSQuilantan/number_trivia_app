import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/error/exception.dart';
import 'package:number_trivia_app/core/error/failure.dart';
import 'package:number_trivia_app/core/utils/json_reader.util.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia.model.dart';
import 'package:number_trivia_app/features/number_trivia/data/repositories/number_trivia.repository_impl.dart';

import '../../../../mocks.dart';

void main() {
  late MockApiRemoteDataSource dataSource;
  late NumberTriviaRepositoryImpl repository;

  setUp(() {
    dataSource = MockApiRemoteDataSource();
    repository = NumberTriviaRepositoryImpl(dataSource);
  });

  final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(jsonReader('number_trivia')));
  final tNumberTrivia = tNumberTriviaModel.toEntity();

  group('getRandomNumberTrivia should', () {
    test(
      'return current Number Trivia call to data source is successful',
      () async {
        //arrange(setup).
        when(() => dataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
        //act(run).
        final result = await repository.getRandomNumberTrivia();
        //assert(verify).
        verify(dataSource.getRandomNumberTrivia);
        expect(result, equals(Right(tNumberTrivia)));
      },
    );

    test(
      'return server failure when a call data source is unsuccessful',
      () async {
        //arrange(setup).
        when(() => dataSource.getRandomNumberTrivia()).thenThrow(ServerException());
        //act(run).
        final result = await repository.getRandomNumberTrivia();
        //assert(verify).
        verify(dataSource.getRandomNumberTrivia);
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'return connection failure when the device has no internet connection',
      () async {
        //arrange(setup).
        when(() => dataSource.getRandomNumberTrivia()).thenThrow(const SocketException('Failed to connect to the network'));
        //act(run).
        final result = await repository.getRandomNumberTrivia();
        //assert(verify).
        verify(dataSource.getRandomNumberTrivia);
        expect(result, equals(const Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
