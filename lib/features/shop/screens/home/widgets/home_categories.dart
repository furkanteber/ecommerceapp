import 'package:ecommerceapp/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:ecommerceapp/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:ecommerceapp/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            title: 'Shoes',
            image: TImages.shoeIcon,
            onTap: () => Get.to(() => SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}
