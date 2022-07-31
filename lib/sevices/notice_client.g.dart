// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationNode _$NotificationNodeFromJson(Map<String, dynamic> json) =>
    NotificationNode(
      date: json['date'] as String,
      description: json['description'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as int,
    );

Map<String, dynamic> _$NotificationNodeToJson(NotificationNode instance) =>
    <String, dynamic>{
      'date': instance.date,
      'description': instance.description,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _NotificationClient implements NotificationClient {
  _NotificationClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://p-cube-plus.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<NotificationNode>> getListData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};

    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/notification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!['notification_list'] as List<dynamic>;

    return value
        .map<NotificationNode>((e) => NotificationNode.fromJson(e))
        .toList();
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
