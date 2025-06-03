import 'package:ecommerceapp/common/widgets/list_tiles/payment_tile.dart';
import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/shop/models/payment_method_model.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      image: TImages.paypal, name: 'Paypal')),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      image: TImages.googlePay, name: 'Google Play')),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      image: TImages.applePay, name: 'Apple Pay')),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(image: TImages.visa, name: 'Visa')),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      image: TImages.masterCard, name: 'Master Card')),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      image: TImages.creditCard, name: 'Credit Cart')),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
