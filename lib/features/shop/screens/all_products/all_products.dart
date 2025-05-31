import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/common/widgets/appbar/appbar.dart';
import 'package:ecommerceapp/common/widgets/effects/vertical_product_shimmer.dart';
import 'package:ecommerceapp/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecommerceapp/features/shop/controllers/all_products_controller.dart';
import 'package:ecommerceapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Popular Products'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsQuery(query),
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
              final products = snapshot.data!;
              return TSortableProducts(
                products: products,
              );
            },
          ),
        ),
      ),
    );
  }
}
