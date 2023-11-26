import 'dart:convert';

import '../models/project.dart';
import 'pcube_api.dart';

class ProjectListApi extends PCubeApi {
  ProjectListApi({int? id}) : super(endPoint: "/project");

  Future<List<Project>?> getProjectList() async {
    Map<String, String>? headers = null;
    var response = await get(headers: headers);

    switch (response.statusCode) {
      case 200:
        List<dynamic> json = jsonDecode(response.body);
        //print(response.body);

        List<Project> projectList =
            json.map((e) => Project.fromJson(e)).toList();
        return projectList;
      default:
        return null;
    }
  }
}
