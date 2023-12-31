import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';

part 'admin.g.dart';

@RestApi(baseUrl: 'https://weplan.parkjb.com/api/admin')
abstract class AdminRestClient {
  factory AdminRestClient(Dio dio, {String baseUrl}) = _AdminRestClient;

  // admin mode
  // channels
  @POST('/channels')
  Future<void> createChannel({
    @Field() required String name,
    @Field() required String place,
  });

  @DELETE('/channels/{channelId}')
  Future<void> deleteChannel({
    @Path('channelId') required int channelId,
  });

  @PATCH('/channels/{channelId}')
  Future<void> modifyChannel({
    @Path('channelId') required int channelId,
    @Field() String? name,
    @Field() String? place,
  });

  // schedules
  @GET('/schedules/requests')
  Future<GetSchedulesRequestsResponse> getScheduleRequests();

  @POST('/schedules/requests')
  Future<void> approveSchedule({
    @Field() required int id,
    @Field() required Approval approval,
  });
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
