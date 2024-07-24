import 'package:flutter/material.dart';

import '../app_colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll<Color>(AppColors.buttonColor),
          minimumSize: const WidgetStatePropertyAll<Size>(Size(20,60)),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ))
        ),
        child: const Text('Back to Plinko', style: TextStyle(
          color: Colors.white,
          fontSize: 16
        ))
      ),
    );
  }
}
