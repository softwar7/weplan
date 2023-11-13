import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final String refreshTokenKey = 'RefreshToken';
  final String accessTokenKey = 'AccessToken';
  final String isAdmin = 'IsAdmin';

  final storage = const FlutterSecureStorage();

  Future<String?> get accessToken async =>
      await storage.read(key: accessTokenKey);
  Future<String?> get refreshToken async =>
      await storage.read(key: refreshTokenKey);
  Future<bool?> get isAdminUser async =>
      await storage.read(key: isAdmin) == 'true';

  Future<void> setAccessToken(String? value) async =>
      await storage.write(key: accessTokenKey, value: value);
  Future<void> setRefreshToken(String? value) async =>
      await storage.write(key: refreshTokenKey, value: value);
  Future<void> setIsAdminUser(bool value) async =>
      await storage.write(key: isAdmin, value: value.toString());

  Future<void> deleteAccessToken() async =>
      await storage.delete(key: accessTokenKey);
  Future<void> deleteRefreshToken() async =>
      await storage.delete(key: refreshTokenKey);
  Future<void> deleteIsAdminUser() async => await storage.delete(key: isAdmin);
}
