import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/interfaces/usecase.interface.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.entity.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.usecase.dart';

import '../../../../mocks.dart';

void main() {
  late MockNumberTriviaRepository repository;
  late GetRandomNumberTriviaUseCase useCase;

  setUp(() {
    repository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTriviaUseCase(repository);
  });

  const tNumberTrivia = NumberTrivia(
    text: 'tText',
    number: 1,
  );
  test(
    'should return a NumberTrivia Entity',
    () async {
      //arrange(setup).
      when(() => repository.getRandomNumberTrivia()).thenAnswer((_) async => const Right(tNumberTrivia));
      //act(run).
      final result = await useCase(NoParams());
      //assert(verify).
      expect(result, equals(const Right(tNumberTrivia)));
    },
  );
}
