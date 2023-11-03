import 'package:json_annotation/json_annotation.dart';

import 'package:weplan/models/enum/approval.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  final int id;
  final String name;
  final String? content;
  final DateTime start;
  final DateTime end;
  final int channelId;
  final Approval approval;

  Schedule({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.channelId,
    required this.approval,
    this.content,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
