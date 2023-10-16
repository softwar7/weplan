import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'package:weplan/models/enum/role_type.dart';

part 'sign.g.dart';

@RestApi(baseUrl: 'http://localhost:8080/api')
abstract class SignRestClient {
  factory SignRestClient(Dio dio, {String baseUrl}) = _SignRestClient;
  // signup / signin
  @POST('/signup')
  Future<SignUpPostResponse> signUp({
    @Body() required SignUpPostRequest request,
  });

  @POST('/signin')
  Future<HttpResponse<SignInPostResponse>> signIn({
    @Body() required SignInPostRequest request,
  });
}

@JsonSerializable()
class SignInPostRequest {
  String loginId;
  String password;

  SignInPostRequest({
    required this.loginId,
    required this.password,
  });

  factory SignInPostRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInPostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignInPostRequestToJson(this);
}

@JsonSerializable()
class SignInPostResponse {
  bool isAdmin;

  SignInPostResponse({
    required this.isAdmin,
  });

  factory SignInPostResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInPostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInPostResponseToJson(this);
}

@JsonSerializable()
class SignUpPostRequest {
  String loginId;
  String password;
  String name;
  String phoneNumber;
  RoleType roleType;
  String? adminPassword;

  SignUpPostRequest({
    required this.loginId,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.roleType,
    this.adminPassword,
  });

  factory SignUpPostRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpPostRequestToJson(this);
}

@JsonSerializable()
class SignUpPostResponse {
  SignUpPostResponse();

  factory SignUpPostResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpPostResponseToJson(this);
}
