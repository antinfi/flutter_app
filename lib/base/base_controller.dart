import 'package:dio/dio.dart';

import '../config/config.dart';
import '../data/network/clients/api_client.dart';
import '../data/network/clients/auth_client.dart';

class BaseController extends GetxController {
  MessageHelper get messageHelper => Get.find<MessageHelper>();

  ConnectivityHelper get connectivity => Get.find<ConnectivityHelper>();

  AppPref get appPref => Get.find<AppPref>();

  SecurePref get securePref => Get.find<SecurePref>();

  ApiClient get apiClient => Get.find<ApiClient>();

  AuthClient get authClient => Get.find<AuthClient>();

  void hideMessage() => messageHelper.hide();

  void showError(String message, {Duration? duration}) => messageHelper.showError(message, duration: duration);

  void showInfo(String message, {Duration? duration}) => messageHelper.showInfo(message, duration: duration);

  void showWarn(String message, {Duration? duration}) => messageHelper.showWarn(message, duration: duration);

  void showSuccess(String message, {Duration? duration}) => messageHelper.showSuccess(message, duration: duration);

  Future<T?> callApi<T>(Future<T> request, {bool showLoader = true, double? loaderTopPadding, bool handleException = false}) async {
    if (!connectivity.isConnected) {
      openWarningDialog('Internet not available');
      return null;
    }
    try {
      if (showLoader) showAppLoader(loaderTopPadding: loaderTopPadding);
      final response = await request;
      if (showLoader) dismissAppLoader();
      return response;
    } on DioError catch (dioError) {
      if (showLoader) dismissAppLoader();
      onResponseError(dioError);
      if (handleException) rethrow;
    } catch (error) {
      if (showLoader) dismissAppLoader();
      if (handleException) rethrow;
      debugPrint('callApi :: Error -> $error');
    }
    return null;
  }

  void onResponseError(onError) {
    debugPrint('onResponseError:onError ${onError.toString()} || ${onError.response?.statusCode}');
    if (onError is DioError) {
      switch (onError.response?.statusCode) {
        case 405:
        case 404:
        case 408:
        case 423:
        case 426:
        case 429:
        case 400:
        case 401:
        case 403:
          final msg = onError.response?.data?['error'] as String?;
          openWarningDialog(msg ?? '');
          break;
        case 422:
          final errors = onError.response?.data?['errors'] as Map?;
          final list = <dynamic>[];
          for (final element in errors?.values ?? []) {
            list.addAll(element as List<dynamic>);
          }
          openWarningDialog(list.join(', '));
          break;
        case 500:
          final msg = onError.response?.data?['message'] as String?;
          openWarningDialog(msg ?? 'Internal Server Error');
          break;
        // case 401:
        //   openWarningDialog('Login expires. Please re-login with Phone number.');
        //   Get.find<AppPref>().clear();
        //   Get.offAllNamed(AppRoute.login);
        case 406:
        case 409:
          break;
        default:
          openWarningDialog('Something went wrong...');
          break;
      }
    }
  }
}
