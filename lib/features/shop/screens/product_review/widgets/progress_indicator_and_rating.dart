import 'package:ecommerceapp/utils/constants/colors.dart';
import 'package:ecommerceapp/utils/device/device_utilitiy.dart';
import 'package:flutter/material.dart';

class TProgressIndicator extends StatelessWidget {
  const TProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              borderRadius: BorderRadius.circular(10),
              minHeight: 11,
              backgroundColor: TColors.grey,
              valueColor: AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
