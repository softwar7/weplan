import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:weplan/models/channel.dart';
import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';

part 'guest.g.dart';

@RestApi(baseUrl: 'https://weplan.parkjb.com/api/guest')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  // guest mode
  // channels
  @GET('/channels')
  Future<GetChannelsResponse> getChannels();

  @GET('/channels/{channelId}')
  Future<Channel> getChannel({
    @Path('channelId') required int channelId,
  });

  // schedules
  @GET('/schedules')
  Future<GetSchedulesResponse> getSchedules({
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('channelId') required int channelId,
  });

  @GET('/schedules/{scheduleId}')
  Future<Schedule> getSchedule({
    @Path('scheduleId') required int scheduleId,
  });

  @POST('/schedules')
  Future<void> createSchedule(
    @Body() CreateScheduleRequest body,
    // @Field('channelId') required int channelId,
    // @Field('name') required String name,
    // @Field('content') String? content,
    // // TODO: Is there a way to serialize DateTime to String?
    // @Field('start') required String start,
    // // TODO: Is there a way to serialize DateTime to String?
    // @Field('end') required String end,
  );

  // // TODO
  // @DELETE('/schedules/{scheduleId}')
  // Future<void> deleteSchedule({
  //   @Path('scheduleId') int scheduleId,
  // });

  // // TODO
  // @PATCH('/schedules/{scheduleId}')
  // Future<void> updateSchedule({
  //   @Path('scheduleId') int scheduleId,
  //   @Field('name') String? name,
  //   @Field('content') String? content,
  //   @Field('start') String? start,
  //   @Field('end') String? end,
  //   @Field('channelId') int? channelId,
  // });

  // schedules requests
  @GET('/schedules/requests')
  Future<GetSchedulesResponse> getScheduleRequests({
    @Query('approval') Approval? approval,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });
  // @GET('/schedules/requests')
  // Future<GetSchedulesResponse> getScheduleRequests();
}

extension Iso8061SerializableDateTime on DateTime {
  String toJson() => this.toIso8601String();
}

@JsonSerializable()
class CreateScheduleRequest {
  final int channelId;
  final String name;
  final String? content;
  final DateTime start;
  final DateTime end;

  CreateScheduleRequest({
    required this.channelId,
    required this.name,
    this.content,
    required this.start,
    required this.end,
  });

  factory CreateScheduleRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateScheduleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateScheduleRequestToJson(this);
}

@JsonSerializable()
class GetSchedulesResponse {
  final List<Schedule> schedules;

  GetSchedulesResponse({
    required this.schedules,
  });

  factory GetSchedulesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSchedulesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSchedulesResponseToJson(this);
}

@JsonSerializable()
class GetChannelsResponse {
  final List<Channel> channels;

  GetChannelsResponse({
    required this.channels,
  });

  factory GetChannelsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetChannelsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetChannelsResponseToJson(this);
}
