import 'package:ecommerceapp/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:ecommerceapp/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: -300,
              child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1)),
            ),
            Positioned(
              top: -100,
              right: -250,
              child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
