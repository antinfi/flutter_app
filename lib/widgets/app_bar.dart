import 'package:flutter/material.dart';

import 'app_button.dart';

class OurAppBar extends AppBar {
  OurAppBar.logIn({VoidCallback? onTapGlobe, VoidCallback? onTapMore})
      : super(
          elevation: 1,
          leading: AppButton.globe(onTap: onTapGlobe),
          actions: [AppButton.more(onTap: onTapMore)],
        );
}
