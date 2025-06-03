import 'package:ecommerceapp/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerceapp/common/widgets/texts/product_price_text.dart';
import 'package:ecommerceapp/features/shop/controllers/cart_controller.dart';
import 'package:ecommerceapp/features/shop/screens/cart/add_remove_button.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              TCartItem(
                cartItem: item,
              ),
              if (showAddRemoveButtons)
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        TProductQuantityWithAddRemove(
                          quantity: item.quantity,
                          add: () => cartController.addOneCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    TProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1)),
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
