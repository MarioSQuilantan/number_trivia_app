import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app/core/interfaces/usecase.interface.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.usecase.dart';

import '../../domain/entities/number_trivia.entity.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTriviaUseCase getRandomNumberTrivia;

  NumberTriviaBloc({
    required this.getRandomNumberTrivia,
  }) : super(NumberTriviaInitial()) {
    on<GetRandomNumberTrivia>(_onGetRandomNumberTrivia);
  }

  void _onGetRandomNumberTrivia(GetRandomNumberTrivia event, Emitter<NumberTriviaState> emit) async {
    emit(NumberTriviaIsLoading());
    final response = await getRandomNumberTrivia(NoParams());
    response.fold(
      (failure) => emit(NumberTriviaHasError(failure.message)),
      (data) => emit(NumberTriviaHasData(data)),
    );
  }
}
