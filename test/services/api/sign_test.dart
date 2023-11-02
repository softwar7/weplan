import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weplan/services/api/sign.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/utils/logger.dart';

void main() {
  AuthService authService = AuthService();

  group('SignIn', () {
    test('signIn', () async {
      HttpResponse<SignInPostResponse> res;
      try {
        res = await authService.signIn(
          loginId: 'weplan',
          password: 'weplan1234',
        );
        expect(res.response.statusCode, 200);
      } on DioException catch (e) {
        logger.e(e.response!.statusCode);
        logger.e(e.response!.statusMessage);
        assert(false);
      }
    });
  });
}
