import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/features/shop/controllers/product/add_new_rating_controller.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewRatingScreen extends StatelessWidget {
  const AddNewRatingScreen({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Add new Rating'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.ratingFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.comment,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Comment field cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Iconsax.user), labelText: 'Comment'),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Rate this product:',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => RatingBar.builder(
                    initialRating: controller.rating.value.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 32,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      controller.rating.value = rating.round();
                    },
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.submitRating(product),
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
