import 'package:ecommerceapp/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerceapp/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerceapp/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultsScreen extends StatelessWidget {
  final String query;
  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(title: Text('Search Results')),
      body: FutureBuilder<List<ProductModel>>(
        future: controller.searchProductsByBrandName(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found for "$query"'));
          }

          final results = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: TGridLayout(
              itemCount: results.length,
              itemBuilder: (_, index) => TProductCardVertical(
                product: results[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
