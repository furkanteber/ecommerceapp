import 'package:ecommerceapp/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());

    final dark = THelperFuncitons.isDarkMode(context);
    return Column(children: [
      TSectionHeading(
        title: 'Payment Method',
        buttonTitle: 'Change',
        onPressed: () => controller.selectPaymentMethod(context),
      ),
      const SizedBox(
        height: TSizes.spaceBtwItems / 2,
      ),
      Obx(
        () => Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: Image(
                image: AssetImage(controller.selectedPaymentMethod.value.image),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Text(
              controller.selectedPaymentMethod.value.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      )
    ]);
  }
}
