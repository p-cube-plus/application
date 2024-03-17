import 'dart:convert';

import 'package:p_cube_plus_application/models/message.dart';
import 'package:p_cube_plus_application/models/notification_node.dart';
import 'package:http/http.dart' as http;
import 'base/pcube_api.dart';

class NoticeListApi extends PCubeApi {
  NoticeListApi({int? id}) : super(endPoint: "/notification/list");

  @override
  Future<List<NotificationNode>?> get({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    return await super.get(
      successReturnFunction: (response) => (jsonDecode(response.body) as List)
          .map((data) => NotificationNode.fromJson(data))
          .toList(),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }

  @override
  Future<Message> put({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async {
    return await super.put(
      successReturnFunction: (response) =>
          Message.fromJson(jsonDecode(response.body)),
      additionalHeader: additionalHeader,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<NotificationNode?> delete({
    Function(http.Response response)? decodeFsuccessReturnFunctionnction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async {
    return await super.delete(
      decodeFsuccessReturnFunctionnction: (response) =>
          Message.fromJson(jsonDecode(response.body)),
      additionalHeader: additionalHeader,
      body: body,
      encoding: encoding,
    );
  }
}
