import 'package:flutter/material.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/pages_widget/setting_widget/reset_pw_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        appBar: thirdAppBar(),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              ResetPasswordWidget(),
            ],
          ),
        ),
      ),
    );
  }
}