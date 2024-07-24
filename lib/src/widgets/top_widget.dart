import 'package:flutter/material.dart';

import '../app_colors.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Music', style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500
          )),

          RichText(
            text: const TextSpan(
              text: '237 ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
              children: [
                TextSpan(
                  text: 'Online',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  )
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}
