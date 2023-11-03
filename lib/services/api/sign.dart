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
  Future<HttpResponse<void>> signUp({
    @Field('loginId') required String loginId,
    @Field('password') required String password,
    @Field('name') required String name,
    @Field('phoneNumber') required String phoneNumber,
    @Field('roleType') required RoleType roleType,
    @Field('adminPassword') String? adminPassword,
  });

  @POST('/signin')
  Future<HttpResponse<SignInPostResponse>> signIn({
    @Field('loginId') required String loginId,
    @Field('password') required String password,
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
