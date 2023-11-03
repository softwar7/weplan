// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as int,
      name: json['name'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      channelId: json['channelId'] as int,
      approval: $enumDecode(_$ApprovalEnumMap, json['approval']),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'channelId': instance.channelId,
      'approval': _$ApprovalEnumMap[instance.approval]!,
    };

const _$ApprovalEnumMap = {
  Approval.APPROVED: 'APPROVED',
  Approval.PENDING: 'PENDING',
  Approval.REJECTED: 'REJECTED',
};
