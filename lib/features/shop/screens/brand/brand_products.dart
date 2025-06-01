import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/brands/brand_card.dart';
import 'package:ecommerceapp/common/widgets/effects/vertical_product_shimmer.dart';
import 'package:ecommerceapp/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecommerceapp/features/shop/controllers/brand_controller.dart';
import 'package:ecommerceapp/features/shop/models/brand_model.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(brand.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TBrandCard(showBorder: true, brand: brand),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              FutureBuilder(
                future: controller.getBrandProducts(brand.id),
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
                  final brandProducts = snapshot.data!;
                  return TSortableProducts(
                    products: brandProducts,
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
