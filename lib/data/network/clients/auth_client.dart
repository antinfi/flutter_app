import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/auth_models.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @POST('auth/login')
  @FormUrlEncoded()
  Future<LoginRes> loginByEmail(@Body() Map<String, dynamic> map);

  @POST('auth/loginbyphone')
  @FormUrlEncoded()
  Future<LoginRes> loginByPhone(@Body() Map<String, dynamic> map);

  @POST('identity/create')
  @FormUrlEncoded()
  Future<IdentityRes> createIdentity(@Body() Map<String, dynamic> map);

  @POST('auth/signup_v2')
  @FormUrlEncoded()
  Future<SignupRes> signup(@Body() Map<String, dynamic> map);

  @POST('user/verify/{code}')
  @FormUrlEncoded()
  Future<LoginRes> verify(@Path('code') String code, @Body() Map<String, dynamic> map);

  @POST('client/update')
  @FormUrlEncoded()
  Future<LoginRes> updateDetail(@Body() Map<String, dynamic> map);

  @POST('user/reset')
  @FormUrlEncoded()
  Future<dynamic> resendCode(@Body() Map<String, dynamic> map);
}
