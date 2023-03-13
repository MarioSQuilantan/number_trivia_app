// routes
import 'package:flutter/material.dart';

class RouteConstants {
  static String home = '/';
}

class ApiConstants {
  static const String _baseUrl = 'http://numbersapi.com';
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static String get getRandomNumberTrivia => '$_baseUrl/random/trivia?json';
}

class HomePhoneLayoutKeys {
  static const Key getRandomNumberTrivia = Key('get_random_number_trivia');
  static const Key numberTriviaData = Key('number_trivia_data');
}

class Routes {
  static const String home = '/';
}
