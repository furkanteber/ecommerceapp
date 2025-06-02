import 'package:ecommerceapp/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:ecommerceapp/features/personalization/controllers/address_controller.dart';
import 'package:ecommerceapp/features/personalization/models/address_model.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap,});

  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFuncitons.isDarkMode(context);
    final controller = AddressController.instance;

    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
          onTap: onTap,
          child: TRoundedContainer(
            width: double.infinity,
            padding: EdgeInsets.all(TSizes.md),
            showBorder: true,
            backgroundColor: selectedAddress
                ? TColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                    ? TColors.darkerGrey
                    : TColors.grey,
            margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                            ? TColors.light
                            : TColors.dark.withOpacity(0.6)
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: TSizes.md / 2,
                    ),
                    Text(
                      address.formattedPhoneNo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: TSizes.md / 2,
                    ),
                    Text(
                      address.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
