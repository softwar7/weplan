import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:weplan/models/channel.dart';
import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';

part 'guest.g.dart';

@RestApi(baseUrl: 'http://localhost:8080/api')
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
    @Query('channelId') int? channelId,
  });

  @GET('/schedules/{scheduleId}')
  Future<Schedule> getSchedule({
    @Path('scheduleId') required int scheduleId,
  });

  @POST('/schedules')
  Future<void> createSchedule({
    @Field('channelId') required int channelId,
    @Field('name') required String name,
    @Field('content') String? content,
    @Field('start') required DateTime start,
    @Field('end') required DateTime end,
  });

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
  //   @Field('start') DateTime? start,
  //   @Field('end') DateTime? end,
  //   @Field('channelId') int? channelId,
  // });

  // schedules requests
  @GET('/schedules/requests')
  Future<GetSchedulesRequestsResponse> getScheduleRequests({
    @Query('approval') Approval? approval,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
  });
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

@JsonSerializable()
class GetSchedulesRequestsResponse {
  final List<Schedule> schedules;

  GetSchedulesRequestsResponse({
    required this.schedules,
  });

  factory GetSchedulesRequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSchedulesRequestsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetSchedulesRequestsResponseToJson(this);
}
