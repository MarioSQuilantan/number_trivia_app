import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/interfaces/usecase.interface.dart';
import '../entities/number_trivia.entity.dart';
import '../repositories/number_trivia.repository.dart';

class GetRandomNumberTriviaUseCase extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUseCase(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) => repository.getRandomNumberTrivia();
}
