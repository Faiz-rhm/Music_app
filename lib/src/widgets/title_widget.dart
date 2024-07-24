import 'package:flutter/material.dart';
import 'package:marqueer/marqueer.dart';

import '../app_colors.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({
    super.key,
  });

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  final controller = MarqueerController();

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Marqueer(
            pps: 100, /// optional
            controller: controller, /// optional
            direction: MarqueerDirection.rtl,  /// optional
            restartAfterInteractionDuration: const Duration(seconds: 6), /// optional
            restartAfterInteraction: false, /// optional
            onChangeItemInViewPort: (index) {
                print('item index: $index');
            },
            onInteraction: () {
                print('on interaction callback');
            },
            onStarted: () {
                print('on started callback');
            },
            onStopped: () {
                print('on stopped callback');
            },
            child: const Text('Dr. Dre - Still D.R.E. ft. Snoop Dogg (feat.Ros)', style: TextStyle(
              color: Colors.white,
              fontSize: 26
            ), maxLines: 1, overflow: TextOverflow.ellipsis,),
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Set Pantalony', style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16
          )),
        ),
      ],
    );
  }
}
