// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostAdminChannelsRequest _$PostAdminChannelsRequestFromJson(
        Map<String, dynamic> json) =>
    PostAdminChannelsRequest(
      name: json['name'] as String,
      place: json['place'] as String,
    );

Map<String, dynamic> _$PostAdminChannelsRequestToJson(
        PostAdminChannelsRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'place': instance.place,
    };

PatchAdminChannelsRequest _$PatchAdminChannelsRequestFromJson(
        Map<String, dynamic> json) =>
    PatchAdminChannelsRequest(
      name: json['name'] as String?,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$PatchAdminChannelsRequestToJson(
        PatchAdminChannelsRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'place': instance.place,
    };

PostSchedulesRequestsRequest _$PostSchedulesRequestsRequestFromJson(
        Map<String, dynamic> json) =>
    PostSchedulesRequestsRequest(
      id: json['id'] as String,
      approval: $enumDecode(_$ApprovalEnumMap, json['approval']),
    );

Map<String, dynamic> _$PostSchedulesRequestsRequestToJson(
        PostSchedulesRequestsRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'approval': _$ApprovalEnumMap[instance.approval]!,
    };

const _$ApprovalEnumMap = {
  Approval.APPROVED: 'APPROVED',
  Approval.PENDING: 'PENDING',
  Approval.REJECTED: 'REJECTED',
};

GetSchedulesRequestsResponse _$GetSchedulesRequestsResponseFromJson(
        Map<String, dynamic> json) =>
    GetSchedulesRequestsResponse(
      schedules: (json['schedules'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSchedulesRequestsResponseToJson(
        GetSchedulesRequestsResponse instance) =>
    <String, dynamic>{
      'schedules': instance.schedules,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AdminRestClient implements AdminRestClient {
  _AdminRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:8080/api/admin';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<void> createChannel(
      {required PostAdminChannelsRequest request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/channels',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  @override
  Future<GetSchedulesRequestsResponse> getScheduleRequests() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetSchedulesRequestsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/schedules/requests',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GetSchedulesRequestsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> approveSchedule(
      {required PostSchedulesRequestsRequest request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    await _dio.fetch<void>(_setStreamType<void>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/schedules/requests',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
