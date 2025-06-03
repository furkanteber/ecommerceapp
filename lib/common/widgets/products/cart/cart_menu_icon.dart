import 'package:ecommerceapp/features/shop/controllers/cart_controller.dart';
import 'package:ecommerceapp/features/shop/screens/cart/cart.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    final dark = THelperFuncitons.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => CartScreen()),
            icon: Icon(
              Iconsax.shopping_bag,
              color: iconColor,
            )),
        Positioned(
          right: 3,
          child: Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: counterBgColor ?? (dark ? TColors.white : TColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Obx(
              () => Text(
                controller.noOfCartItems.value.toString(),
                style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: counterTextColor ??
                        (dark ? TColors.black : TColors.white),
                    fontSizeFactor: 0.8),
              ),
            ),
          ),
        )
      ],
    );
  }
}
