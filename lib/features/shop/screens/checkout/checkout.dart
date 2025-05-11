import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:ecommerceapp/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerceapp/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerceapp/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerceapp/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerceapp/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerceapp/features/shop/screens/products/cart/coupon_widget.dart';
import 'package:ecommerceapp/navigation_menu.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuncitons.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //İtems in Cart
              const TCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Coupon TextField
              TCouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    //Pricing
                    TBillingAmountSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Divider
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Payment Methods
                    TBillingPaymentSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Address
                    TBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(
            () => SuccessScreen(
              image: TImages.successfulPaymentIcon,
              title: 'Payment Success',
              subTitle: 'Your item will be shipped soon!',
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
          child: Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
