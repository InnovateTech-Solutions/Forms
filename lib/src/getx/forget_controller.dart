import 'package:get/get.dart';
import 'package:profile_part/src/repository/Forget_Password/forget_password.dart';

class ForgetPasswordcontroller extends GetxController {
  static ForgetPasswordcontroller get instance => Get.find();

  passwordRest(context, email) {
    ForgetPasswordRepository().passwordReset(context, email);
  }
}
