import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weplan/services/api/sign.dart';

void main() {
  Dio dio = Dio();
  final signRestClient = SignRestClient(dio);

  group('SignIn', () {
    test('signIn', () async {
      var res = await signRestClient.signIn(
        request: SignInPostRequest(loginId: 'test', password: 'test'),
      );
      expect(res, isA<HttpResponse<SignInPostResponse>>());
      expect(res.response.headers.map['Authorization'], isNotNull);
    });
  });
}
