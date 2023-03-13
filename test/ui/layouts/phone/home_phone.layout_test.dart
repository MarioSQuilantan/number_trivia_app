import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/utils/json_reader.util.dart';
import 'package:number_trivia_app/core/values/constants.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia.model.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_app/ui/home/layouts/phone/home_phone.layout.dart';

import '../../../mocks.dart';

void main() {
  late MockNumberTriviaBloc mockNumberTriviaBloc;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeNumberTriviaEvent());
    registerFallbackValue(FakeNumberTriviaState());

    final di = GetIt.instance;
    di.registerFactory(() => mockNumberTriviaBloc);
  });

  setUp(() {
    mockNumberTriviaBloc = MockNumberTriviaBloc();
  });

  final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(jsonReader('number_trivia')));
  final tNumberTrivia = tNumberTriviaModel.toEntity();

  Widget widgetTester(Widget body) {
    return BlocProvider<NumberTriviaBloc>.value(
      value: mockNumberTriviaBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'ElevatedButton with key [getRandomNumberTrivia] should trigger the state from [NumberTriviaInitial] to [NumberTriviaIsLoading]',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaInitial());
      // act
      await tester.pumpWidget(widgetTester(const HomePhoneLayout()));
      await tester.tap(find.byKey(HomePhoneLayoutKeys.getRandomNumberTrivia));
      await tester.pumpAndSettle();
      // assert
      verify(() => mockNumberTriviaBloc.add(GetRandomNumberTriviaEvent())).called(1);
      expect(find.byKey(HomePhoneLayoutKeys.getRandomNumberTrivia), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show progress indicator when state is [NumberTriviaIsLoading]',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaIsLoading());
      // act
      await tester.pumpWidget(widgetTester(const HomePhoneLayout()));
      // assert
      expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show Widget containing Number Trivia data when state is [NumberTriviaHasData]',
    (WidgetTester tester) async {
      // arrange
      when(() => mockNumberTriviaBloc.state).thenReturn(NumberTriviaHasData(tNumberTrivia));
      // act
      await tester.pumpWidget(widgetTester(const HomePhoneLayout()));
      await tester.runAsync(() async {
        final HttpClient client = HttpClient();
        await client.getUrl(Uri.parse(ApiConstants.getRandomNumberTrivia));
      });
      await tester.pumpAndSettle();
      // assert

      expect(find.byKey(HomePhoneLayoutKeys.numberTriviaData), equals(findsOneWidget));
    },
  );
}
