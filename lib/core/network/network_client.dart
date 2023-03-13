abstract class NetworkClient {
  Future get(
    String url, {
    Map<String, dynamic>? queryParameters,
  });

  // Future<Type> delete(
  //   String url, {
  //   data,
  //   Map<String, dynamic>? queryParameters,

  // });

  // Future<Type> post(
  //   String url, {
  //   data,
  //   Map<String, dynamic>? queryParameters,
  // });

  // Future<Type> put(
  //   String url, {
  //   data,
  //   Map<String, dynamic>? queryParameters,
  // });
}
