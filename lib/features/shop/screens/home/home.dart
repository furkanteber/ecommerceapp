import 'package:ecommerceapp/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:ecommerceapp/common/widgets/custom_shapes/container/search_container.dart';
import 'package:ecommerceapp/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerceapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerceapp/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerceapp/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerceapp/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  //AppBar
                  const THomeAppBar(),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //Searchbar
                  const TSearchContainer(text: 'Search in Store'),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: TColors.white,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        // Categories
                        THomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner1,
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => const AllProducts()),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => TProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
