import 'package:http/http.dart' as http;

const String _baseUrl = "http://p-cube-plus.com";

abstract class PCubeApi {
  final String endPoint;

  PCubeApi({required this.endPoint});

  Future<http.Response> get(
      {Map<String, String>? headers, Map<String, String>? queryParams}) async {
    var response = await http.get(
      Uri.parse(_baseUrl + endPoint).replace(queryParameters: queryParams),
      headers: headers,
    );

    return response;
  }
}
