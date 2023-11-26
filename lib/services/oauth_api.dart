import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/oauth_token.dart';
import 'pcube_api.dart';

class OAuthAPI extends PCubeApi {
  OAuthAPI() : super(endPoint: "/oauth/naver/login");

  Future<OAuthToken?> naver(String refreshToken, String identifier, String name,
      String phoneNumber) async {
    Map<String, String>? headers = {"Content-Type": "application/json"};
    Map<String, String>? queryParams = {
      "refresh_token": refreshToken,
      "identifier": identifier,
      "name": name,
      "phone_number": phoneNumber,
    };
    var response = await get(headers: headers, queryParams: queryParams);

    Map<String, dynamic> json = jsonDecode(response.body);
    OAuthToken user = OAuthToken.fromJson(json);

    return user;
  }
}
