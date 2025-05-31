import 'package:ecommerceapp/common/widgets/brands/brand_show_case.dart';
import 'package:ecommerceapp/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerceapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/shop/models/category_model.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Brands
                const TBrandShowCase(
                  images: [
                    TImages.productImage1,
                    TImages.productImage2,
                    TImages.productImage3
                  ],
                ),
                const TBrandShowCase(
                  images: [
                    TImages.productImage1,
                    TImages.productImage2,
                    TImages.productImage3
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                //Products
                TSectionHeading(
                  title: 'You night like',
                  showActionButton: true,
                  onPressed: () {},
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => TProductCardVertical(
                          product: ProductModel.empty(),
                        )),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}
