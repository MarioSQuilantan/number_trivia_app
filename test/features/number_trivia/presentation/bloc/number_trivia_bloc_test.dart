import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/error/failure.dart';
import 'package:number_trivia_app/core/interfaces/usecase.interface.dart';
import 'package:number_trivia_app/core/utils/json_reader.util.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia.model.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import '../../../../mocks.dart';

void main() {
  late MockGetRandomNumberTriviaUseCase getRandomNumberTrivia;
  late NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    getRandomNumberTrivia = MockGetRandomNumberTriviaUseCase();
    numberTriviaBloc = NumberTriviaBloc(getRandomNumberTrivia: getRandomNumberTrivia);
  });

  final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(jsonReader('number_trivia')));
  final tNumberTrivia = tNumberTriviaModel.toEntity();

  test('initial state should be empty', () {
    expect(numberTriviaBloc.state, NumberTriviaInitial());
  });

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'should emit [loading, hasData] when data is gotten successfully',
    build: () {
      when(() => getRandomNumberTrivia(NoParams())).thenAnswer((_) async => Right(tNumberTrivia));
      return numberTriviaBloc;
    },
    act: (bloc) => bloc.add(GetRandomNumberTrivia()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NumberTriviaIsLoading(),
      NumberTriviaHasData(tNumberTrivia),
    ],
    verify: (bloc) {
      verify(() => getRandomNumberTrivia(NoParams()));
    },
  );

  blocTest<NumberTriviaBloc, NumberTriviaState>(
    'should emit [loading, error] when the data is unsuccessfully',
    build: () {
      when(() => getRandomNumberTrivia(NoParams())).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return numberTriviaBloc;
    },
    act: (bloc) => bloc.add(GetRandomNumberTrivia()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NumberTriviaIsLoading(),
      const NumberTriviaHasError('Server Failure'),
    ],
    verify: (bloc) {
      verify(() => getRandomNumberTrivia(NoParams()));
    },
  );
}
