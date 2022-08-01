import 'dart:convert';

import '../models/user.dart';
import 'pcube_api.dart';

class UserProfileApi extends PCubeApi {
  UserProfileApi() : super(endPoint: "/user/profile");

  Future<User?> getUser() async {
    var response = await send();

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> json = jsonDecode(response.body);
        User user = User.fromJson(json);

        return user;
      default:
        return null;
    }
  }
}
