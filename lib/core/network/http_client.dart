import 'dart:io';

import 'package:number_trivia_app/core/network/network_client.dart';
import 'package:http/http.dart' as http_client;
import 'package:number_trivia_app/core/values/constants.dart';

class HttpClient implements NetworkClient {
  final http_client.Client http;

  HttpClient(this.http);

  @override
  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) {
    return http.get(
      Uri(
        path: url,
        queryParameters: queryParameters,
      ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      },
    ).timeout(ApiConstants.connectionTimeout);
  }
}
