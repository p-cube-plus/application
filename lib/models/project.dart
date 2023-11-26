import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'member.dart';

@JsonSerializable()
class Project {
  final int id;
  final String name;

  final int type;
  String getType() => "${["메인", "꼬꼬마"][type]}";

  final int status;
  String getStatus() =>
      "${["종료(완성)", "진행중", "준비중", "동결", "종료 임박", "종료(미완성)"][status]}";

  final DateTime? startDate;
  final DateTime? endDate;
  final String? graphic; // tag
  final List<String> platforms; // tag
  final bool isFindingMember;
  final bool isAbleInquiry; // 문의 가능한지
  final List<Member> members;
  final Member pm;

  Project({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.graphic,
    required this.platforms,
    required this.isFindingMember,
    required this.isAbleInquiry,
    required this.members,
    required this.pm,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
      graphic: json['graphic'],
      platforms: (json['platform'] as List<dynamic>)
          .map<String>((e) => e.toString())
          .toList(),
      isFindingMember: json['is_finding_member'],
      isAbleInquiry: json['is_able_inquiry'],
      members: (json['members'] as List<dynamic>)
          .map<Member>((e) => Member.fromJson(e))
          .toList(),
      pm: Member.fromJson(json['pm']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'status': status,
        'start_date': startDate == null
            ? null
            : DateFormat('yyyy-mm-dd').format(startDate!),
        'end_date':
            endDate == null ? null : DateFormat('yyyy-mm-dd').format(endDate!),
        'graphic': graphic,
        'platforms': platforms,
        'is_finding_member': isFindingMember,
        'is_able_inquiry': isAbleInquiry,
        'members': members,
        'pm': pm,
      };
}
