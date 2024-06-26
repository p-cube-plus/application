import 'package:json_annotation/json_annotation.dart';
import 'package:p_cube_plus_application/models/schedule.dart';

@JsonSerializable()
class HomeSchedule {
  final List<Schedule> allList;
  final List<Schedule> upcomingList;

  HomeSchedule({
    required this.allList,
    required this.upcomingList,
  });

  factory HomeSchedule.fromJson(Map<String, dynamic> json) {
    return HomeSchedule(
      allList: (json['all_list'] as List)
          .map<Schedule>((data) => Schedule.fromJson(data))
          .toList(),
      upcomingList: (json['upcoming_list'] as List)
          .map<Schedule>((data) => Schedule.fromJson(data))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'all_list': allList,
        'upcoming_list': upcomingList,
      };
}
