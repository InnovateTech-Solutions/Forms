import 'package:ecommerce/src/constant/app_const.dart';
import 'package:ecommerce/src/getx/profile_controller.dart';
import 'package:ecommerce/src/getx/register_controller.dart';
import 'package:ecommerce/src/model/login_model.dart';
import 'package:ecommerce/src/model/user_model.dart';
import 'package:ecommerce/src/widget/Text_Widget/form_text.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/button_widget.dart';
import 'package:ecommerce/src/widget/custom_Widget.dart/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../repository/user_repository/user_repository.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({Key? key}) : super(key: key);

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final usercontroller = Get.put(UserRepository());
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final validator = Get.put(RegisterController());
    return FutureBuilder(
        future: controller.getUserData(),
        builder: ((context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.hasData) {
              UserModel userData = snapShot.data as UserModel;
              final id = TextEditingController(text: userData.id);
              final email = TextEditingController(text: userData.email);
              final userName = TextEditingController(text: userData.name);
              final phoneNumber = TextEditingController(text: userData.phone);
              final password = TextEditingController(text: userData.password);
              return Form(
                  key: controller.fromkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      imagepicker(),
                      mainText(userName.text),
                      SizedBox(
                        height: 650.h,
                        width: 400.w,
                        child: ListView(
                          padding: EdgeInsets.all(30.h.w),
                          children: [
                            textFieldLabel(AppConst.email),
                            FormWidget(
                                login: Login(
                                    controller: email,
                                    hintText: 'Email',
                                    icon: const Icon(Icons.email_rounded),
                                    invisible: false,
                                    validator: (email) =>
                                        validator.validateEmail(email),
                                    type: TextInputType.emailAddress,
                                    onChange: null,
                                    inputFormat: [])),
                            SizedBox(
                              height: AppConst.smallSize.h,
                            ),
                            textFieldLabel(AppConst.username),
                            FormWidget(
                                login: Login(
                                    controller: userName,
                                    hintText: 'Username',
                                    icon: const Icon(Icons.person),
                                    invisible: false,
                                    validator: (userName) =>
                                        validator.vaildateUserName(userName),
                                    type: TextInputType.name,
                                    onChange: null,
                                    inputFormat: [])),
                            SizedBox(
                              height: AppConst.smallSize.h,
                            ),
                            textFieldLabel(AppConst.phoneNumber),
                            FormWidget(
                                login: Login(
                                    controller: phoneNumber,
                                    hintText: 'Phone Number',
                                    icon: const Icon(Icons.phone),
                                    invisible: false,
                                    validator: (phoneNumber) =>
                                        validator.vaildPhoneNumber(phoneNumber),
                                    type: TextInputType.number,
                                    onChange: null,
                                    inputFormat: [])),
                            SizedBox(
                              height: AppConst.smallSize.h,
                            ),
                            textFieldLabel(AppConst.password),
                            FormWidget(
                                login: Login(
                                    controller: password,
                                    hintText: 'Password',
                                    icon: const Icon(Icons.lock),
                                    invisible: true,
                                    validator: (password) =>
                                        validator.vaildatePassword(password),
                                    type: TextInputType.text,
                                    onChange: null,
                                    inputFormat: [])),
                            SizedBox(
                              height: AppConst.smallSize.h,
                            ),
                            ButtonWidget(
                                onTap: () async {
                                  if ((controller.fromkey.currentState!
                                      .validate())) {
                                    final userData = UserModel(
                                      id: id.text.trim(),
                                      email: email.text.trim(),
                                      name: userName.text.trim(),
                                      password: password.text.trim(),
                                      phone: phoneNumber.text.trim(),
                                    );
                                    await controller.updateRecord(userData);
                                  }
                                },
                                tilte: 'UPDATE')
                          ],
                        ),
                      ),
                    ],
                  ));
            } else if (snapShot.hasError) {
              return Center(child: Text(snapShot.error.toString()));
            } else {
              return const Text("somthing went wrong");
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  imagepicker() {
    return GestureDetector(
      onTap: () {
        usercontroller.pickUpImage();
      },
      child: Container(
        width: 150.w,
        height: 150.h,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: SvgPicture.asset(
          "assets/ProfilePicUploade.svg",
          width: 100.w,
          height: 100.h,
        ),
      ),
    );
  }
}