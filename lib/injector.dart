import 'package:get_it/get_it.dart';
import 'package:number_trivia_app/core/network/http_client.dart';

import 'features/number_trivia/data/datasources/api_remote.datasource.dart';
import 'features/number_trivia/data/repositories/number_trivia.repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia.repository.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.usecase.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // blocs
  locator.registerFactory(() => NumberTriviaBloc(getRandomNumberTrivia: locator<GetRandomNumberTriviaUseCase>()));

  //use cases
  locator.registerLazySingleton(() => GetRandomNumberTriviaUseCase(locator<NumberTriviaRepository>()));

  // repositories
  locator.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(locator<ApiRemoteDataSource>()));

  // data sources
  locator.registerLazySingleton<ApiRemoteDataSource>(() => ApiRemoteDataSourceImpl(locator<HttpClient>()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => HttpClient(locator<http.Client>()));
}
