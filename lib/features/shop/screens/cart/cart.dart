import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerceapp/features/shop/controllers/cart_controller.dart';
import 'package:ecommerceapp/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerceapp/features/shop/screens/checkout/checkout.dart';
import 'package:ecommerceapp/navigation_menu.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final emptyWidget = Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TAnimationLoader(
                text: 'Whoopss! Cart is Empty',
                animation: TImages.cartAnimation,
                showAction: true,
                actionText: 'Let\'s fill it',
                onActionPressed: () => Get.off(() => const NavigationMenu()),
              ),
            ),
          ),
        );

        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: TCartItems(),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(() =>
                    Text('Checkout \$${controller.totalCartPrice.value}')),
              ),
            ),
    );
  }
}
