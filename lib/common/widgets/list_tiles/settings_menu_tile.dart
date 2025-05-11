import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFuncitons.isDarkMode(context);
    return ListTile(
      leading: Icon(icon, size: 28, color: TColors.primary),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .apply(color: dark ? TColors.white : TColors.black),
      ),
      subtitle: Text(subTitle,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: dark ? TColors.white : TColors.black)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
