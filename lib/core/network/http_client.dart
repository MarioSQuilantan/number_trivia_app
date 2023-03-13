import 'package:number_trivia_app/core/network/network_client.dart';
import 'package:http/http.dart' as http_client;

class HttpClient implements NetworkClient {
  final http_client.Client http;

  HttpClient(this.http);

  @override
  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) {
    return http.get(Uri.parse(url).replace(queryParameters: queryParameters));
  }
}
