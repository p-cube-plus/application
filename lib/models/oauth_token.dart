import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OAuthToken {
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  OAuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory OAuthToken.fromJson(Map<String, dynamic> json) {
    return OAuthToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'message': message,
      };
}
