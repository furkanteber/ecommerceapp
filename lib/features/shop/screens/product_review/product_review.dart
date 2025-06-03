import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerceapp/features/shop/controllers/product/add_new_rating_controller.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/features/shop/screens/product_details/widgets/add_new_rating.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/widgets/rating_progress_indicator.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/widgets/user_review_card.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => AddNewRatingScreen(
                        product: product,
                      )),
                  child: Text('New Comment'),
                ),
              ),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              //Overall Product Ratings
              TOverallProductRating(
                product: product,
              ),
              FutureBuilder(
                  future: controller.fetchAverageRating(product.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final averageRating = snapshot.data ?? 0.0;
                    return TRatingBarIndicator(
                      rating: averageRating,
                    );
                  }),
              FutureBuilder(
                  future: controller.fetchRatingCount(product.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final ratingCount = snapshot.data ?? 0;
                    return Text(
                      '$ratingCount Customer',
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  }),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //User Reviews List
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .doc(product.id)
                    .collection('Reviews')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('Not Comment Found');
                  }

                  final reviews = snapshot.data!.docs;

                  return Column(
                    children: reviews.map((review) {
                      final data = review.data() as Map<String, dynamic>;
                      return UserReviewCard(
                        username: data['userId'] ?? 'Unknown',
                        comment: data['comment'] ?? '',
                        photoUrl: data['userPhoto'] ?? '',
                        rating: (data['rating'] as num).toDouble(),
                        createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
