import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/core/utils/json_reader.util.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia.model.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(jsonReader('number_trivia')));

  final tNumberTrivia = tNumberTriviaModel.toEntity();

  group('toEntity should', () {
    test(
      'be a subclass to NumberTrivia Entity',
      () async {
        //assert(verify).
        expect(tNumberTrivia, equals(tNumberTriviaModel.toEntity()));
      },
    );
  });

  group('fromJson should', () {
    test(
      'return a valid model fromJson',
      () async {
        //arrange(setup).
        final Map<String, dynamic> jsonMap = jsonDecode(jsonReader('number_trivia'));
        //act(run).
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert(verify).
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'return a valid model fromJson when the number is a double',
      () async {
        //arrange(setup).
        final Map<String, dynamic> jsonMap = jsonDecode(jsonReader('number_trivia_double'));
        //act(run).
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert(verify).
        expect(result, equals(tNumberTriviaModel));
      },
    );
  });

  group('toJson should', () {
    test(
      'return a json map containing a proper data',
      () async {
        //arrange(setup).
        final result = tNumberTriviaModel.toJson();
        final expectedJsonMap = {
          'text': 'tText',
          'number': 1,
        };
        //assert(verify).
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
