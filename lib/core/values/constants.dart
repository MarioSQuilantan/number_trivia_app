// routes
class RouteConstants {
  static String home = '/';
}

class ApiConstants {
  static const String _baseUrl = 'http://numbersapi.com/';
  static const Duration connectionTimeout = Duration(seconds: 15);

  static String get getRandomNumberTrivia => '$_baseUrl/random/trivia?json';
}
