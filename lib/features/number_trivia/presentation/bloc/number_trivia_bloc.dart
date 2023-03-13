import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/interfaces/usecase.interface.dart';
import '../../domain/entities/number_trivia.entity.dart';
import '../../domain/usecases/get_random_number_trivia.usecase.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetRandomNumberTriviaUseCase getRandomNumberTrivia;

  NumberTriviaBloc({
    required this.getRandomNumberTrivia,
  }) : super(NumberTriviaInitial()) {
    on<GetRandomNumberTriviaEvent>(_onGetRandomNumberTrivia);
  }

  void _onGetRandomNumberTrivia(GetRandomNumberTriviaEvent event, Emitter<NumberTriviaState> emit) async {
    emit(NumberTriviaIsLoading());
    final response = await getRandomNumberTrivia(NoParams());
    response.fold(
      (failure) => emit(NumberTriviaHasError(failure.message)),
      (data) => emit(NumberTriviaHasData(data)),
    );
  }
}
