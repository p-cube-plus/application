import 'package:flutter/material.dart';
import '../models/member.dart';
import '../services/project_api.dart';
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  late ProjectListApi _client;

  bool loaded = false;
  bool fail = false;

  late List<Project>? _projectList;
  List<Project>? get projectList => loaded ? _projectList : null;

  ProjectProvider() {
    initialize();
  }

  void initialize() {
    update();
  }

  Future<List<Project>?> _getProjects() async {
    //_client = ProjectListApi();
    //List<Project>? _projectList = await _client.getProjectList();
    List<Project>? _projectList = _getDummyProjects();

    return _projectList;
  }

  List<Project>? _getDummyProjects() {
    return <Project>[
      Project(
        id: 0,
        type: 0,
        name: "PCube+",
        status: 2,
        startDate: DateTime(2022, 05, 27),
        endDate: DateTime(2023, 01, 31),
        members: <Member>[
          Member(
              id: 0,
              isSigned: true,
              name: "오창한",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 1,
              isSigned: true,
              name: "권오민",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 2,
              isSigned: true,
              name: "신혜민",
              level: 1,
              partIdx: 2,
              profileImage: null),
          Member(
              id: 3,
              isSigned: true,
              name: "조승빈",
              level: 1,
              partIdx: 1,
              profileImage: null),
          Member(
              id: 3,
              isSigned: true,
              name: "정성희",
              level: 1,
              partIdx: 1,
              profileImage: null),
        ],
        pm: Member(
            id: 0,
            isSigned: true,
            name: "오창한",
            level: 1,
            partIdx: 1,
            profileImage: null),
        platforms: <String>["Android"],
        graphic: "2D",
        isFindingMember: false,
        isAbleInquiry: true,
      ),
    ];
  }

  Project? getProject({int? id, int? index}) {
    if (!loaded) return null;
    if (id == null && index == null) return null;
    if (index != null) return _projectList![index];

    var projects = _projectList!.where((e) => e.id == id);

    return projects.isEmpty ? null : projects.first;
  }

  void update() async {
    _projectList = await _getProjects();

    fail = _projectList == null;
    loaded = true;

    notifyListeners();
  }
}
