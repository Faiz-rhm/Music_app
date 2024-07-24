import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../app_colors.dart';

class VolumeWidget extends StatelessWidget {
  const VolumeWidget(
    this.player, {
    super.key,
  });

  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if(player.volume > 1.3877787807814457e-16) player.setVolume(player.volume - 0.1);
          },
          icon: const Icon(Icons.volume_mute, color: AppColors.volumeColor,)
        ),

        Expanded(
          child: StreamBuilder<double>(
            stream: player.volumeStream,
            builder: (context, snapshot) => SizedBox(
              height: 50.0,
              child: Slider(
                activeColor: AppColors.volumeColor,
                inactiveColor: AppColors.pauseButtonColor,
                autofocus: true,
                divisions: 10,
                min: 0.0,
                max: 1.0,
                value: snapshot.data ?? player.volume,
                onChanged: player.setVolume,
              ),
            ),
          ),
        ),

        IconButton(
          onPressed: () {
            if(player.volume < 1.0) player.setVolume(player.volume + 0.1);
          },
          icon: const Icon(Icons.volume_up_sharp, color: AppColors.volumeColor,)
        ),
      ],
    );
  }
}
