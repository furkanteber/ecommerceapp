import 'package:ecommerceapp/common/widgets/effects/category_shimmer.dart';
import 'package:ecommerceapp/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:ecommerceapp/features/shop/controllers/category_controller.dart';
import 'package:ecommerceapp/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return TVerticalImageText(
              title: category.name,
              image: category.image,
              onTap: () => Get.to(() => SubCategoriesScreen(category: category)),
            );
          },
        ),
      );
    });
  }
}
