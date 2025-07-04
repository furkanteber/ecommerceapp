import 'package:ecommerceapp/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerceapp/common/widgets/texts/product_title_text.dart';
import 'package:ecommerceapp/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:ecommerceapp/features/shop/models/cart_item_model.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:ecommerceapp/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuncitons.isDarkMode(context);
    return Row(
      children: [
        //Image
        TRoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        //Title Price Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: TProductTitleText(
                  title: cartItem.title,
                  maxLines: 1,
                ),
              ),

              //Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {})
                      .entries
                      .map((e) => TextSpan(children: [
                            TextSpan(
                                text: ' ${e.key}',
                                style: Theme.of(context).textTheme.bodySmall),
                            TextSpan(
                                text: '${e.value}',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ]))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
