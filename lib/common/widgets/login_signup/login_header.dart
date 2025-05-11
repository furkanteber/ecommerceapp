import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/constants/text_strings.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuncitons.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          dark ? TImages.lightAppLogo : TImages.darkAppLogo,
          width: TSizes.loginLogoWitdh,
        ),
        Text(
          TText.loginTitle,
          style: TextStyle(
              fontSize: TSizes.fontSizeLg, fontWeight: FontWeight.w800),
        ),
        Text(
          TText.loginSubTitle,
          style: TextStyle(
              fontSize: TSizes.fontSizeSm, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
