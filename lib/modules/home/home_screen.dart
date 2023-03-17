import '../../config/config.dart';
import '../../widgets/app_button.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            AppButton.settings(onTap: () => Get.toNamed(AppRoute.settings)),
          ]),
        ),
      );
}
