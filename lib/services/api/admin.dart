import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/models/schedule.dart';

part 'admin.g.dart';

@RestApi(baseUrl: 'http://localhost:8080/api/admin')
abstract class AdminRestClient {
  factory AdminRestClient(Dio dio, {String baseUrl}) = _AdminRestClient;

  // admin mode
  // channels
  @POST('/channels')
  Future<void> createChannel({
    @Body() required PostAdminChannelsRequest request,
  });

  // // TODO
  // @DELETE("/channels/{channelId}")
  // Future<void> deleteChannel({
  //   @Path("channelId") String channelId,
  // });

  // // TODO
  // @PATCH("/channels/{channelId}")
  // Future<void> updateChannel({
  //   @Path("channelId") String channelId,
  //   @Body() PatchRequest request,
  // });

  // schedules
  @GET('/schedules/requests')
  Future<GetSchedulesRequestsResponse> getScheduleRequests();

  @POST('/schedules/requests')
  Future<void> approveSchedule({
    @Body() required PostSchedulesRequestsRequest request,
  });
}

@JsonSerializable()
class PostAdminChannelsRequest {
  final String name;
  final String place;

  PostAdminChannelsRequest({
    required this.name,
    required this.place,
  });

  factory PostAdminChannelsRequest.fromJson(Map<String, dynamic> json) =>
      _$PostAdminChannelsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostAdminChannelsRequestToJson(this);
}

@JsonSerializable()
class PatchAdminChannelsRequest {
  final String? name;
  final String? place;

  PatchAdminChannelsRequest({
    this.name,
    this.place,
  });

  factory PatchAdminChannelsRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchAdminChannelsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchAdminChannelsRequestToJson(this);
}

@JsonSerializable()
class PostSchedulesRequestsRequest {
  final String id;
  final Approval approval;

  PostSchedulesRequestsRequest({
    required this.id,
    required this.approval,
  });

  factory PostSchedulesRequestsRequest.fromJson(Map<String, dynamic> json) =>
      _$PostSchedulesRequestsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostSchedulesRequestsRequestToJson(this);
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
