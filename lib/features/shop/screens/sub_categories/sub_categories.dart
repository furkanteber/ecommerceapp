import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/effects/vertical_product_shimmer.dart';
import 'package:ecommerceapp/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerceapp/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/shop/controllers/category_controller.dart';
import 'package:ecommerceapp/features/shop/models/category_model.dart';
import 'package:ecommerceapp/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              TRoundedImage(
                width: double.infinity,
                applyImageRadius: true,
                imageUrl: TImages.banner1,
                isNetworkImage: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Sub Categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loader;
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No Data Found!"),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }

                    final subCategories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                const loader = TVerticalProductShimmer();
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return loader;
                                }

                                if (!snapshot.hasData ||
                                    snapshot.data == null ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text("No Data Found!"),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('Something went wrong'),
                                  );
                                }
                                final products = snapshot.data!;
                                return Column(
                                  children: [
                                    // Heading
                                    TSectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(() => AllProducts(
                                            title: subCategory.name,
                                            futureMethod:
                                                controller.getCategoryProducts(
                                                    categoryId: subCategory.id,
                                                    limit: -1),
                                          )),
                                      showActionButton: true,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwItems / 2,
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                width: TSizes.spaceBtwItems,
                                              ),
                                          itemBuilder: (context, index) =>
                                              TProductCardHorizontal(
                                                  product: products[index])),
                                    ),
                                  ],
                                );
                              });
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
