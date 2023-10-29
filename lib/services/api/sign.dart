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
    @Field('loginId') required String loginId,
    @Field('password') required String password,
    @Field('name') required String name,
    @Field('phoneNumber') required String phoneNumber,
    @Field('roleType') required RoleType roleType,
    @Field('adminPassword') String? adminPassword,
    // @Body() required SignUpPostRequest request,
  });

  @POST('/signin')
  Future<HttpResponse<SignInPostResponse>> signIn({
    @Field('loginId') required String loginId,
    @Field('password') required String password,
    // @Body() required SignInPostRequest request,
  });
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
class SignUpPostResponse {
  SignUpPostResponse();

  factory SignUpPostResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpPostResponseToJson(this);
}
