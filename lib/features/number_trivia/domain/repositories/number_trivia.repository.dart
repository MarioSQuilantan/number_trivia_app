import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/number_trivia.entity.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
