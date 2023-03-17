import 'dart:io';

import '../../../../config/config.dart';
import '../../../../widgets/app_button.dart';
import 'personal_information_controller.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({Key? key}) : super(key: key);

  final controller = Get.find<PersonalInformationController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('personalInformation'.tr)),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: controller.formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Gap(30),
                      AppText.medium('yourDetailsMatchHere'.tr, size: 16, textAlign: TextAlign.center),
                      const Gap(32),
                      GestureDetector(
                        onTap: controller.selectImage,
                        child: SizedBox.square(
                          dimension: 80,
                          child: Obx(() {
                            if (controller.selfieImage.value == null) return Assets.icons.personalCamera.svg();
                            return CircleAvatar(
                              backgroundColor: AppColor.transparent,
                              backgroundImage: FileImage(File(controller.selfieImage.value!.path)),
                            );
                          }),
                        ),
                      ),
                      const Gap(32),
                      AppTextField.fill(
                        controller.firstNameTextController,
                        hintText: '${'firstName'.tr}*',
                        textInputType: TextInputType.name,
                        validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'firstName'.tr}) : null,
                      ),
                      const Gap(16),
                      AppTextField.fill(
                        controller.middleNameTextController,
                        hintText: 'middleName'.tr,
                        textInputType: TextInputType.name,
                      ),
                      const Gap(16),
                      AppTextField.fill(
                        controller.lastNameTextController,
                        hintText: '${'lastName'.tr}*',
                        textInputType: TextInputType.name,
                        validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'lastName'.tr}) : null,
                      ),
                      const Gap(16),
                      AppTextField.fill(
                        controller.dateTimeTextController,
                        hintText: 'dateOfBirthDdmmyy'.tr,
                        textInputType: TextInputType.datetime,
                        suffixIcon: IconButton(onPressed: null, icon: Assets.icons.calendar.svg(width: 22, height: 22)),
                        enabled: false,
                        onTap: controller.openDatePicker,
                        validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'dateOfBirthDdmmyy'.tr}) : null,
                      ),
                      const Gap(16),
                      AppTextField.fill(
                        controller.countryTextController,
                        hintText: 'country'.tr,
                        textInputType: TextInputType.name,
                        validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'country'.tr}) : null,
                      ),
                      const Gap(16),
                      AppTextField.fill(
                        controller.cityTextController,
                        hintText: 'city'.tr,
                        textInputType: TextInputType.name,
                        validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'city'.tr}) : null,
                      ),
                      const Gap(16),
                      AppTextField.fill(
                        controller.streetNumberTextController,
                        hintText: 'streetAndNumber'.tr,
                        textInputType: TextInputType.name,
                        validator: (value) => value.isNullOrEmpty ? 'pleaseEnterYour'.trParams({'info': 'streetAndNumber'.tr}) : null,
                      ),
                      const Gap(32),
                      Obx(() {
                        final isMaleButtonSelected = controller.isMale.value;
                        return Row(children: [
                          Expanded(
                            child: AppButton.male(
                              filled: isMaleButtonSelected,
                              onTap: isMaleButtonSelected ? null : () => controller.isMale.value = true,
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: AppButton.female(
                              filled: !isMaleButtonSelected,
                              onTap: !isMaleButtonSelected ? null : () => controller.isMale.value = false,
                            ),
                          ),
                        ]);
                      }),
                      const Gap(8),
                      Row(
                        children: [
                          Expanded(child: AppText.medium('male'.tr, size: 16, textAlign: TextAlign.center, color: AppColor.black)),
                          const Gap(16),
                          Expanded(child: AppText.medium('female'.tr, size: 16, textAlign: TextAlign.center, color: AppColor.black)),
                        ],
                      ),
                      const Gap(16),
                      const Spacer(),
                      const Gap(16),
                      AppButton.next(onTap: controller.onNext),
                      Gap(context.navigationBarHeight + 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
