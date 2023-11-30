import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/utilities/error_message.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

const String _baseUrl = "http://p-cube-plus.com";

class PCubeApi {
  PCubeApi({required this.endPoint, this.isExternalApi = false});

  final String endPoint;
  final bool isExternalApi;

  Uri _getUrl() => Uri.parse(_baseUrl + endPoint);

  Map<String, String> _getHeader(Map<String, String>? additionalHeader) {
    var headers = {
      "Content-Type": "application/json",
    };
    if (!isExternalApi) {
      headers.addAll(
          {"Authorization": "Bearer ${TokenManager().getAccessToken()}"});
    }
    if (additionalHeader != null) {
      headers.addAll(additionalHeader);
    }
    return headers;
  }

  get({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    var response = await http.get(
        _getUrl().replace(queryParameters: queryParams),
        headers: _getHeader(additionalHeader));

    if (response.statusCode == 200) {
      try {
        return successReturnFunction!(response.body);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  post(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.post(_getUrl(),
        headers: _getHeader(additionalHeader), body: body, encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return successReturnFunction!(response.body);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  put(
      {Function(dynamic body)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.put(_getUrl(),
        headers: _getHeader(additionalHeader), body: body, encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return successReturnFunction!(response.body);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }

  delete(
      {Function(dynamic body)? decodeFsuccessReturnFunctionnction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    var response = await http.delete(_getUrl(),
        headers: _getHeader(additionalHeader), body: body, encoding: encoding);

    if (response.statusCode == 200) {
      try {
        return decodeFsuccessReturnFunctionnction!(response.body);
      } catch (e) {
        throw new Exception(FailedToConvertJSONData().message);
      }
    } else {
      throw new Exception(FailedToGetServerData().message);
    }
  }
}