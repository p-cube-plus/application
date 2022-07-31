import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_client.g.dart';

@RestApi(baseUrl: "http://p-cube-plus.com")
abstract class NotificationClient {
  factory NotificationClient(Dio dio, {String baseUrl}) = _NotificationClient;

  @GET("/user/notification") // 해당 api 경로
  Future<List<NotificationNode>> getListData();
  //@Header("user_id") String userId,
  //@Header("Authorization") String token,
  //@Body() PracticeRequest request);
}

@JsonSerializable()
class NotificationNode {
  final String date;
  final String description;
  final int id;
  final String name;
  final int type;

  NotificationNode({
    required this.date,
    required this.description,
    required this.id,
    required this.name,
    required this.type,
  });

  factory NotificationNode.fromJson(Map<String, dynamic> json) =>
      _$NotificationNodeFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationNodeToJson(this);
}
