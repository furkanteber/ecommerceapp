import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Review & Ratings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              //Overall Product Ratings
              TOverallProductRating(),
              TRatingBarIndicator(
                rating: 3.5,
              ),
              Text(
                '12.611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //User Reviews List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
