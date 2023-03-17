import 'dart:io';

import '../../../../config/config.dart';
import '../../../../widgets/app_button.dart';
import 'identification_document_controller.dart';

class IdentificationDocumentScreen extends StatelessWidget {
  IdentificationDocumentScreen({Key? key}) : super(key: key);

  final controller = Get.find<IdentificationDocumentController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('identificationDocument'.tr)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 8),
          child: Form(
            key: controller.formKey,
            child: Obx(() {
              final items = Column(
                children: [
                  const Gap(32),
                  AppText.regular(
                    'identificationDocumentDescription'.tr,
                    size: 16,
                    color: AppColor.textPrimary.withOpacity(0.8),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(32),
                  Obx(() {
                    final isPassportSelected = controller.isPassport.value;
                    return Row(children: [
                      Expanded(
                        child: AppButton.idCard(
                          filled: !isPassportSelected,
                          onTap: isPassportSelected ? controller.isPassport.toggle : null,
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: AppButton.passport(
                          filled: isPassportSelected,
                          onTap: !isPassportSelected ? controller.isPassport.toggle : null,
                        ),
                      ),
                    ]);
                  }),
                  if (controller.documentImage.value == null) ...[
                    const Spacer(),
                    Assets.icons.identificationCard.image(),
                  ] else ...[
                    const Gap(20),
                    AppTextField.fill(
                      controller.identityNumberTextController,
                      hintText: '${'identityNumber'.tr}*',
                      validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'identityNumber'.tr}) : null,
                    ),
                    const Gap(20),
                    AppTextField.fill(
                      controller.identificationCountryTextController,
                      hintText: '${'identificationCountry'.tr}*',
                      textInputAction: TextInputAction.done,
                      validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'identificationCountry'.tr}) : null,
                      suffixIcon: const IconButton(onPressed: null, icon: Icon(Icons.keyboard_arrow_down, size: 22)),
                      enabled: false,
                      onTap: controller.openIdentificationCountryPicker,
                    ),
                    const Gap(20),
                    AppTextField.fill(
                      controller.dateOfExpiryTextController,
                      hintText: '${'identificationDateOfExpiry'.tr}*',
                      textInputType: TextInputType.datetime,
                      validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'identificationDateOfExpiry'.tr}) : null,
                      suffixIcon: IconButton(onPressed: null, icon: Assets.icons.calendar.svg(width: 22, height: 22)),
                      enabled: false,
                      onTap: controller.openDatePicker,
                    ),
                    const Gap(20),
                    AppTextField.fill(
                      controller.documentPlaceOfIssueTextController,
                      hintText: '${'documentPlaceOfIssue'.tr}*',
                      textInputType: TextInputType.datetime,
                      validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'documentPlaceOfIssue'.tr}) : null,
                      suffixIcon: const IconButton(onPressed: null, icon: Icon(Icons.keyboard_arrow_down, size: 22)),
                      enabled: false,
                      onTap: controller.openDocumentIssueCountryPicker,
                    ),
                  ],
                  if (controller.documentImage.value == null) const Spacer() else const Gap(20),
                  Obx(() {
                    if (controller.anotherDocumentImage.value != null) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primary),
                          borderRadius: const BorderRadius.all(Radius.circular(14)),
                        ),
                        padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                        child: Row(
                          children: [
                            const Gap(4),
                            Image.file(File(controller.anotherDocumentImage.value?.path ?? ''), width: 62, height: 36),
                            Expanded(
                              child: AppText.medium(
                                controller.anotherDocumentImage.value?.name,
                                size: 12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                color: AppColor.black,
                              ),
                            ),
                            IconButton(onPressed: controller.removeAnotherDocument, icon: Assets.icons.close.svg()),
                          ],
                        ),
                      );
                    }

                    return AppButton.documentPicture(
                      alreadyUploaded: controller.documentImage.value != null,
                      onTap: controller.uploadDocument,
                    );
                  }),
                  const Gap(32),
                  AppButton.send(onTap: controller.onSendTap),
                  const Gap(kToolbarHeight),
                ],
              );

              return controller.documentImage.value == null
                  ? items
                  : SingleChildScrollView(
                      child: items,
                    );
            }),
          ),
        ),
      );
}
