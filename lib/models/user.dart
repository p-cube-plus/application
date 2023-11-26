import 'promotion_progress.dart';
import 'caution.dart';
import 'project.dart';
import 'seminar.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String? profileImage;
  final String level;
  final int partIndex;
  final List<Project> projects;
  final List<Caution> cautions;
  final List<Seminar> seminars;
  final PromotionProgress promotionProgress;

  User({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.level,
    required this.partIndex,
    required this.projects,
    required this.cautions,
    required this.seminars,
    required this.promotionProgress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      profileImage: json['profile_image'],
      level: json['level'],
      partIndex: json['part_index'],
      projects: (json['projects'] as List<dynamic>)
          .map<Project>((e) => Project.fromJson(e))
          .toList(),
      cautions: (json['caution_list'] as List<dynamic>)
          .map<Caution>((e) => Caution.fromJson(e))
          .toList(),
      seminars: (json['recent_seminar'] as List<dynamic>)
          .map<Seminar>((e) => Seminar.fromJson(e))
          .toList(),
      promotionProgress: PromotionProgress.fromJson(json['promotion_progress']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profile_image': profileImage,
        'level': level,
        'part_index': partIndex,
        'projects': projects,
        'caution_list': cautions,
        'recent_seminar': seminars,
        'promotion_progress': promotionProgress,
      };
}
