import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:country_picker/country_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'config/app_theme.dart';
import 'config/config.dart';
import 'translations.dart';

class WorldcomFinanceApp extends StatefulWidget {
  const WorldcomFinanceApp({Key? key}) : super(key: key);

  @override
  State<WorldcomFinanceApp> createState() => _WorldcomFinanceAppState();
}

class _WorldcomFinanceAppState extends State<WorldcomFinanceApp> {
  @override
  void initState() {
    super.initState();

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    // init all things and goto next screen
    Future.wait([
      _getDeviceInfo(),
      _getPackageInfo(),
      _getOtherDetails(),
    ]);
  }

  @override
  void dispose() {
    Get.find<ConnectivityHelper>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Worldcom Finance',
        scaffoldMessengerKey: Get.find<MessageHelper>().messengerKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        getPages: AppRoute.pages,
        initialRoute: AppRoute.initial,
        unknownRoute: GetPage(
          name: '/notFound',
          page: () => const Scaffold(body: Center(child: Text('Not Found'))),
        ),
        builder: (context, widget) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: (MediaQuery.of(context).platformBrightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
              .copyWith(statusBarColor: AppColor.transparent, systemNavigationBarColor: AppColor.transparent),
          child: widget ?? Container(),
        ),
        translations: AppTranslations(),
        locale: Get.deviceLocale,
        supportedLocales: AppTranslations.supportedLocales,
      );

  Future<void> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;
      GlobalVariable.androidApiVersion = info.version.sdkInt;
      GlobalVariable.deviceName = '${info.brand} ${info.model}';

      GlobalVariable.deviceId = (await const AndroidId().getId()) ?? '';
    } else if (Platform.isIOS) {
      final info = await deviceInfoPlugin.iosInfo;
      GlobalVariable.deviceId = info.identifierForVendor ?? '';
      GlobalVariable.deviceName = 'Apple ${info.name} ${info.model}';
    }
  }

  Future<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    GlobalVariable.appVersion = packageInfo.version;
    GlobalVariable.appBuildNumber = packageInfo.buildNumber;
  }

  Future<void> _getOtherDetails() async {
    final systemLocales = WidgetsBinding.instance.window.locales;
    if (!systemLocales.first.countryCode.isNullOrEmpty) {
      final country = CountryParser.parseCountryCode(systemLocales.first.countryCode ?? '');
      GlobalVariable.phoneCode = '+${country.phoneCode}';
    }
  }
}
