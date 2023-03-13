import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/api_remote.datasource.dart';
import 'package:number_trivia_app/features/number_trivia/domain/repositories/number_trivia.repository.dart';
import 'package:http/http.dart' as http_client;
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.usecase.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockHttp extends Mock implements http_client.Client {}

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

class MockApiRemoteDataSource extends Mock implements ApiRemoteDataSource {}

class MockGetRandomNumberTriviaUseCase extends Mock implements GetRandomNumberTriviaUseCase {}

class MockNumberTriviaBloc extends MockBloc<NumberTriviaEvent, NumberTriviaState> implements NumberTriviaBloc {}

class FakeNumberTriviaState extends Fake implements NumberTriviaState {}

class FakeNumberTriviaEvent extends Fake implements NumberTriviaEvent {}
