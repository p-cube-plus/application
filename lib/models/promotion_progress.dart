import 'package:json_annotation/json_annotation.dart';
import 'package:p_cube_plus_application/models/curriculum.dart';

@JsonSerializable()
class PromotionProgress {
  final bool semester;

  final Curriculum curriculum;

  final double progress;
  final bool projectAttended;
  final int? projectType;

  final bool workshopComplete;
  final int workshopCount;

  final bool vote;

  PromotionProgress({
    required this.semester,
    required this.curriculum,
    required this.progress,
    required this.projectAttended,
    required this.projectType,
    required this.workshopComplete,
    required this.workshopCount,
    required this.vote,
  });

  factory PromotionProgress.fromJson(Map<String, dynamic> json) {
    return PromotionProgress(
      semester: json['semester'],
      curriculum: Curriculum.fromJson(json['curriculum']),
      progress: json['progress'],
      projectAttended: json['project']['attended'],
      projectType: json['project']['type'],
      workshopComplete: json['workshop']['complete'],
      workshopCount: json['workshop']['count'],
      vote: json['vote'],
    );
  }

  Map<String, dynamic> toJson() => {
        'semester': semester,
        'curriculum': curriculum,
        'progress': progress,
        'project': {
          'attended': projectAttended,
          'type': projectType,
        },
        'workshop': {
          'complete': workshopComplete,
          'count': workshopCount,
        },
        'vote': vote,
      };
}
