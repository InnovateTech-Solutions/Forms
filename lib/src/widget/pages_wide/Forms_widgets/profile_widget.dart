import 'package:ecommerce/src/View/setting/setting_page.dart';
import 'package:ecommerce/src/View/setting/update_profile.dart';
import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../getx/profile_controller.dart';
import '../../../model/button_model.dart';
import '../../../model/user_model.dart';
import '../../../repository/authentication/authentication_repository.dart';
import '../../../repository/user_repository/user_repository.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final userController = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    final controllerr = Get.put(ProfileController());
    List<Button> profile = [
      Button(
          title: 'My Appointments',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
          title: 'Payment Method',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () {}),
      Button(
          title: 'Setting',
          icon: SvgPicture.asset(
            'assets/arrow.svg',
            matchTextDirection: true,
            width: 15.w,
            height: 15.h,
          ),
          onTap: () => Get.to(const SettingPage())),
      Button(
        title: 'Logout',
        icon: SvgPicture.asset(
          'assets/arrow.svg',
          matchTextDirection: true,
          width: 15.w,
          height: 15.h,
        ),
        onTap: () => AuthenticationRepository().logout(),
      ),
    ];
    return FutureBuilder(
      future: controllerr.getUserData(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          if (snapShot.hasData) {
            UserModel userData = snapShot.data as UserModel;
            final userName = TextEditingController(text: userData.name);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/Profilepic.svg",
                          width: 100.w,
                          height: 100.h,
                        ),
                        SizedBox(
                          height: AppConst.smallSize,
                        ),
                        blueText(userName.text),
                        SizedBox(
                          height: AppConst.smallSize,
                        ),
                        divder(115.w, 0, 0),
                        Center(
                            child: textButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateProfile()));
                        }, "View Profile")),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.separated(
                          itemCount: profile.length,
                          itemBuilder: ((context, index) {
                            return profileWidget(profile[index]);
                          }),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: AppConst.medium,
                            );
                          },
                        ),
                      ))
                ],
              ),
            );
          } else if (snapShot.hasError) {
            return Center(child: Text(snapShot.error.toString()));
          } else {
            return const Text("somthing went wrong");
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}