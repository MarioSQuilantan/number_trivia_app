part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaIsLoading extends NumberTriviaState {}

class NumberTriviaHasData extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const NumberTriviaHasData(this.numberTrivia);
}

class NumberTriviaHasError extends NumberTriviaState {
  final String message;

  const NumberTriviaHasError(this.message);
}
