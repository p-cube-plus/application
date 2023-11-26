import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Member {
  final int id;
  final bool isSigned; // 가입 여부
  final String name;
  final int level; // 정회원, 수습, 졸업, 탈퇴

  final int partIdx;
  String getPart() => "${["디자인", "프로그래밍", "아트"][partIdx]}";

  final String? profileImage;

  Member({
    required this.id,
    required this.isSigned,
    required this.name,
    required this.level,
    required this.partIdx,
    required this.profileImage,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      isSigned: json['is_signed'],
      name: json['name'],
      level: json['level'],
      partIdx: json['part_idx'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_signed': isSigned,
        'name': name,
        'level': level,
        'part_idx': partIdx,
        'profile_image': profileImage,
      };
}
