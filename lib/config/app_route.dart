import 'package:get/get.dart';

import '../modules/auth/forgot_password/forgot_password_binding.dart';
import '../modules/auth/forgot_password/forgot_password_screen.dart';
import '../modules/auth/login/login_binding.dart';
import '../modules/auth/login/login_screen.dart';
import '../modules/auth/mobile_verification/mobile_verification_binding.dart';
import '../modules/auth/mobile_verification/mobile_verification_screen.dart';
import '../modules/auth/register/account_information/account_information_binding.dart';
import '../modules/auth/register/account_information/account_information_screen.dart';
import '../modules/auth/register/identification_document/identification_document_binding.dart';
import '../modules/auth/register/identification_document/identification_document_screen.dart';
import '../modules/auth/register/personal_information/personal_information_binding.dart';
import '../modules/auth/register/personal_information/personal_information_screen.dart';
import '../modules/auth/set_new_password/set_new_password_binding.dart';
import '../modules/auth/set_new_password/set_new_password_screen.dart';
import '../modules/contact_us/contact_us_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_screen.dart';
import '../modules/settings/my_account/my_account_binding.dart';
import '../modules/settings/my_account/my_account_screen.dart';
import '../modules/settings/security/security_binding.dart';
import '../modules/settings/security/security_screen.dart';
import '../modules/settings/settings_binding.dart';
import '../modules/settings/settings_screen.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';

abstract class AppRoute {
  static String get initial => splash;

  // auth
  static const splash = '/splash';
  static const login = '/login';
  static const identificationDocument = '/identificationDocument';
  static const accountInformation = '/accountInformation';
  static const mobileVerification = '/mobileVerification';
  static const personalInformation = '/personalInformation';
  static const forgotPassword = '/forgotPassword';
  static const setNewPassword = '/setNewPassword';
  static const contactUs = '/contactUs';

  // home
  static const home = '/home';

  // settings
  static const settings = '/settings';
  static const myAccount = '/myAccount';
  static const security = '/security';

  static final pages = [
    GetPage(name: splash, binding: SplashBinding(), page: SplashScreen.new),
    GetPage(name: login, binding: LoginBinding(), page: LoginScreen.new),
    GetPage(name: home, binding: HomeBinding(), page: HomeScreen.new),
    GetPage(name: identificationDocument, binding: IdentificationDocumentBinding(), page: IdentificationDocumentScreen.new),
    GetPage(name: accountInformation, binding: AccountInformationBinding(), page: AccountInformationScreen.new),
    GetPage(name: mobileVerification, binding: MobileVerificationBinding(), page: MobileVerificationScreen.new),
    GetPage(name: personalInformation, binding: PersonalInformationBinding(), page: PersonalInformationScreen.new),
    GetPage(name: forgotPassword, binding: ForgotPasswordBinding(), page: ForgotPasswordScreen.new),
    GetPage(name: setNewPassword, binding: SetNewPasswordBinding(), page: SetNewPasswordScreen.new),
    GetPage(name: contactUs, page: ContactUsScreen.new),
    GetPage(name: settings, binding: SettingsBinding(), page: SettingsScreen.new),
    GetPage(name: myAccount, binding: MyAccountBinding(), page: MyAccountScreen.new),
    GetPage(name: security, binding: SecurityBinding(), page: SecurityScreen.new),
  ];
}
