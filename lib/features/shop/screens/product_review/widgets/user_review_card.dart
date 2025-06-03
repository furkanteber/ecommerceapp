import 'package:ecommerceapp/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerceapp/features/shop/controllers/product/add_new_rating_controller.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard(
      {super.key,
      required this.username,
      required this.comment,
      required this.photoUrl,
      required this.rating,
      this.createdAt});

  final String username;
  final String comment;
  final String photoUrl;
  final double rating;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    //final dark = THelperFuncitons.isDarkMode(context);
    final controller = Get.put(RatingController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(photoUrl),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  username,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        //Review
        Row(
          children: [
            TRatingBarIndicator(rating: rating),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              controller.formatTimestampToDate(createdAt),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        ReadMoreText(
          comment,
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: ' show more',
          moreStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
          lessStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: TColors.primary),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        //Company Review
        /*
        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TeberStore',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '02 Jan, 2025',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                ReadMoreText(
                  'The user interface of the app is quite intvitive.I was able to navigate and make purchases seamlessly.Great job.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: ' show more',
                  moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                  lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary),
                ),
              ],
            ),
          ),
        ),
        */
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
      ],
    );
  }
}
