import 'package:ecommerceapp/features/shop/screens/product_review/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class TOverallProductRating extends StatelessWidget {
  const TOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.5',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              TProgressIndicator(
                text: '5',
                value: 0.9,
              ),
              TProgressIndicator(
                text: '4',
                value: 0.7,
              ),
              TProgressIndicator(
                text: '3',
                value: 0.5,
              ),
              TProgressIndicator(
                text: '2',
                value: 0.3,
              ),
              TProgressIndicator(
                text: '1',
                value: 0.1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
