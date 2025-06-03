import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/personalization/controllers/address_controller.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFuncitons.isDarkMode(context);
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectNewAddressPopup(context),
        ),
        addressController.selectedAddress.value.id.isNotEmpty
            ? Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addressController.selectedAddress.value.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Text(
                          addressController
                              .selectedAddress.value.formattedPhoneNo,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Expanded(
                          child: Text(
                            addressController.selectedAddress.value.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                  ],
                ),
              )
            : Text(
                'Select Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ],
    );
  }
}
