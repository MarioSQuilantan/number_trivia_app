import 'package:number_trivia_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/interfaces/usecase.interface.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.entity.dart';
import 'package:number_trivia_app/features/number_trivia/domain/repositories/number_trivia.repository.dart';

class GetRandomNumberTriviaUseCase extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTriviaUseCase(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) => repository.getRandomNumberTrivia();
}
