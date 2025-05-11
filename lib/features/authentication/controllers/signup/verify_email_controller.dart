import 'dart:async';

import 'package:ecommerceapp/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerceapp/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/text_strings.dart';
import 'package:ecommerceapp/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instace => Get.find();

  @override
  void onInit() {
    sendEmailVerificaiton();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send Email Verification link
  sendEmailVerificaiton() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //Timer to automaticly redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(() => SuccessScreen(
            image: TImages.successfulRegisterAnimation,
            title: TText.yourAccountCreatedTitle,
            subTitle: TText.changeYourPasswordSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }
  //Manually Check if Email Verified

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: TImages.successfulRegisterAnimation,
          title: TText.yourAccountCreatedTitle,
          subTitle: TText.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
