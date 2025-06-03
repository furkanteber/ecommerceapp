import 'package:ecommerceapp/features/shop/controllers/product/add_new_rating_controller.dart';
import 'package:ecommerceapp/features/shop/models/product_model.dart';
import 'package:ecommerceapp/features/shop/screens/product_review/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RatingController());
    return FutureBuilder<Map<String, dynamic>>(
      future: controller.fetchRatingsData(product.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error loading ratings');
        }

        final data = snapshot.data!;
        final average = data['average'] as double;
        final counts = data['counts'] as Map<String, int>;
        final total = data['total'] as int;

        double progress(String star) => total == 0 ? 0 : counts[star]! / total;

        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                average.toStringAsFixed(1), // Örneğin 4.3 gibi gösterir
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  TProgressIndicator(
                    text: '5',
                    value: progress('5'),
                  ),
                  TProgressIndicator(
                    text: '4',
                    value: progress('4'),
                  ),
                  TProgressIndicator(
                    text: '3',
                    value: progress('3'),
                  ),
                  TProgressIndicator(
                    text: '2',
                    value: progress('2'),
                  ),
                  TProgressIndicator(
                    text: '1',
                    value: progress('1'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
