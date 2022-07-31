// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationNode _$NotificationNodeFromJson(Map<String, dynamic> json) =>
    NotificationNode(
      date: json['date'] as String?,
      description: json['description'] as String?,
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
    baseUrl ??= 'p-cube-plus.com/user/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Map<String, List<NotificationNode>>> getListData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};

    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, List<NotificationNode>>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/notification',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));

    var value = _result.data!.map((k, dynamic v) => MapEntry(
        k,
        (v as List)
            .map((i) => NotificationNode.fromJson(i as Map<String, dynamic>))
            .toList()));
    return value;
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
