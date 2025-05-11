import 'package:ecommerceapp/common/styles/spacing_stayles.dart';
import 'package:ecommerceapp/common/widgets/login_signup/form_divider.dart';
import 'package:ecommerceapp/common/widgets/login_signup/login_form.dart';
import 'package:ecommerceapp/common/widgets/login_signup/login_header.dart';
import 'package:ecommerceapp/common/widgets/login_signup/social_buttons.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const TLoginHeader(),
              const TLoginForm(),
              TFormDivider(dividerText: TText.orSignInWith.capitalize!),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
