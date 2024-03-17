import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/models/user/user_project.dart';
import 'package:p_cube_plus_application/models/user/user_warning.dart';

import '../models/user/user_profile.dart';
import 'base/pcube_api.dart';

class UserProfileApi extends PCubeApi {
  UserProfileApi() : super(endPoint: "/user/profile");

  @override
  Future<UserProfile> get(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (response) =>
          UserProfile.fromJson(jsonDecode(response.body)),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }
}

class UserProjectApi extends PCubeApi {
  UserProjectApi() : super(endPoint: "/user/project");

  @override
  Future<List<UserProject>> get(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (response) => (jsonDecode(response.body) as List)
          .map<UserProject>((data) => UserProject.fromJson(data))
          .toList(),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }
}

class UserWarningApi extends PCubeApi {
  UserWarningApi() : super(endPoint: "/user/warning");

  @override
  Future<UserWarning> get(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Map<String, String>? queryParams}) async {
    return await super.get(
      successReturnFunction: (response) =>
          UserWarning.fromJson(jsonDecode(response.body)),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }
}
