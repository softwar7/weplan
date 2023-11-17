import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';


part 'sign.g.dart';

@RestApi(baseUrl: 'https://weplan.parkjb.com/api')
abstract class SignRestClient {
  factory SignRestClient(Dio dio, {String baseUrl}) = _SignRestClient;
  // signup / signin
  @POST('/signup')
  Future<HttpResponse<void>> signUp({
    @Field('loginId') required String loginId,
    @Field('password') required String password,
    @Field('name') required String name,
    @Field('phoneNumber') required String phoneNumber,
    // TODO: Is there a way to serialize RoleType to String?
    @Field('roleType') required String roleType,
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
