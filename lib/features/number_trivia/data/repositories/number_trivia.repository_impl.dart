import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/number_trivia.entity.dart';
import '../../domain/repositories/number_trivia.repository.dart';
import '../datasources/api_remote.datasource.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final ApiRemoteDataSource apiRemoteDataSource;

  NumberTriviaRepositoryImpl(this.apiRemoteDataSource);

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    try {
      final result = await apiRemoteDataSource.getRandomNumberTrivia();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
