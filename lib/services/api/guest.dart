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
    @Query('start') String? start,
    @Query('end') String? end,
    @Query('channelId') required int channelId,
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
    @Field('start') required String start,
    @Field('end') required String end,
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
  //   @Field('start') String? start,
  //   @Field('end') String? end,
  //   @Field('channelId') int? channelId,
  // });

  // schedules requests
  @GET('/schedules/requests')
  Future<GetSchedulesResponse> getScheduleRequests({
    @Query('approval') Approval? approval,
    @Query('start') String? start,
    @Query('end') String? end,
  });
  // @GET('/schedules/requests')
  // Future<GetSchedulesResponse> getScheduleRequests();
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
