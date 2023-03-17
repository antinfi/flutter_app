import '../config/config.dart';

int noOfCallRunning = 0;

void showAppLoader({bool isCancelable = false, double? loaderTopPadding}) {
  if (!(Get.isDialogOpen ?? false)) noOfCallRunning = 0;
  noOfCallRunning++;
  if (noOfCallRunning == 1) _showLoadingDialog(isCancelable, loaderTopPadding);
}

void dismissAppLoader() {
  if (noOfCallRunning == 1) Get.back();
  noOfCallRunning--;
}

void _showLoadingDialog(bool isCancelable, double? loaderTopPadding) {
  Get.dialog(
    WillPopScope(
      onWillPop: () => Future.value(isCancelable),
      child: Builder(
          builder: (context) => Material(
                color: AppColor.transparent,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(color: AppColor.white, borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(),
                        Gap(16),
                        AppText.semiBold('Please wait'),
                      ],
                    ),
                  ),
                ),
              )),
    ),
    barrierDismissible: isCancelable,
  );
}
