// routes
class RouteConstants {
  static String home = '/';
}

class ApiConstants {
  static const String _baseUrl = 'http://numbersapi.com/';
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static String get getRandomNumberTrivia => '$_baseUrl/random/trivia?json';
}
