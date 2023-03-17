import 'config.dart';

// find the route and continue with it
abstract class RouteFinder {
  static String findNextRoute() {
    // check if user logged in
    if (!Get.find<AppPref>().isLogin) {
      return AppRoute.login;
    }

    return AppRoute.home;
  }
}
