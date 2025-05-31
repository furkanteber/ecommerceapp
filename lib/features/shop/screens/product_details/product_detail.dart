import 'package:ecommerceapp/common/widgets/texts/section_heading.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/features/shop/screens/product_details/widgets/bottom_add_to_card_widget.dart';
import 'package:ecommerceapp/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerceapp/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:ecommerceapp/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:ecommerceapp/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/product_review.dart';
import 'package:ecommerceapp/utils/constants/enums.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            TProductImageSlider(
              product: product,
            ),
            // Product Details
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //Rating Share
                  TRatingAndShare(),
                  //Price,Title,Stack
                  TProductMetaData(
                    product: product,
                  ),
                  //Attributes
                  if (product.productType == ProductType.variable.toString())
                    TProductAttributes(
                      product: product,
                    ),
                  //Checkout Button
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Checkout'),
                    ),
                  ),
                  //Description
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  //Reviews
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TSectionHeading(
                        title: 'Reviews(188)',
                        onPressed: () {},
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(() => ProductReviewScreen()),
                        icon: const Icon(
                          Iconsax.arrow_right_34,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
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
