import 'dart:io';

import 'package:number_trivia_app/core/error/exception.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/api_remote.datasource.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.entity.dart';

import 'package:number_trivia_app/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/number_trivia.repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final ApiRemoteDataSource apiRemoteDataSource;

  NumberTriviaRepositoryImpl(this.apiRemoteDataSource);

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    try {
      final result = await apiRemoteDataSource.getRandomNumberTrivia();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
