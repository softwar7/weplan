// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInPostRequest _$SignInPostRequestFromJson(Map<String, dynamic> json) =>
    SignInPostRequest(
      loginId: json['loginId'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInPostRequestToJson(SignInPostRequest instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'password': instance.password,
    };

SignInPostResponse _$SignInPostResponseFromJson(Map<String, dynamic> json) =>
    SignInPostResponse(
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$SignInPostResponseToJson(SignInPostResponse instance) =>
    <String, dynamic>{
      'isAdmin': instance.isAdmin,
    };

SignUpPostRequest _$SignUpPostRequestFromJson(Map<String, dynamic> json) =>
    SignUpPostRequest(
      loginId: json['loginId'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      roleType: $enumDecode(_$RoleTypeEnumMap, json['roleType']),
      adminPassword: json['adminPassword'] as String?,
    );

Map<String, dynamic> _$SignUpPostRequestToJson(SignUpPostRequest instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'password': instance.password,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'roleType': _$RoleTypeEnumMap[instance.roleType]!,
      'adminPassword': instance.adminPassword,
    };

const _$RoleTypeEnumMap = {
  RoleType.ADMIN: 'ADMIN',
  RoleType.GUEST: 'GUEST',
};

SignUpPostResponse _$SignUpPostResponseFromJson(Map<String, dynamic> json) =>
    SignUpPostResponse();

Map<String, dynamic> _$SignUpPostResponseToJson(SignUpPostResponse instance) =>
    <String, dynamic>{};

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SignRestClient implements SignRestClient {
  _SignRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://localhost:8080/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SignUpPostResponse> signUp(
      {required SignUpPostRequest request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SignUpPostResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/signup',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SignUpPostResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignInPostResponse> signIn(
      {required SignInPostRequest request}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SignInPostResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/signin',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SignInPostResponse.fromJson(_result.data!);
    return value;
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
