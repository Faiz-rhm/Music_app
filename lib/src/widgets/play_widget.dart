import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../app_colors.dart';

class PlayWidget extends StatelessWidget {
  const PlayWidget(
    this.player, {
    super.key,
  });

  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(AppColors.pauseButtonColor),
                minimumSize: WidgetStatePropertyAll<Size>(Size(20,70)),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ))
              ),
              icon: const Icon(Icons.skip_previous_sharp, color: Colors.white, size: 50,)
            ),
          ),

          const SizedBox(width: 16,),

          StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return PlayButton(
                  onPressed: player.play,
                  icon: const CircularProgressIndicator(color: Colors.white,),
                );
              } else if (playing != true) {
                return PlayButton(
                  onPressed: player.play,
                  icon: const Icon(Icons.play_arrow, color: Colors.white, size: 50,),
                );
              } else if (processingState != ProcessingState.completed) {
                return PlayButton(
                  onPressed: player.pause,
                  icon: const Icon(Icons.pause, color: Colors.white, size: 50,),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 64.0,
                  onPressed: () => player.seek(Duration.zero),
                );
              }
            },
          ),

          const SizedBox(width: 16,),

          Expanded(
            child: TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(AppColors.pauseButtonColor),
                minimumSize: WidgetStatePropertyAll<Size>(Size(20,70)),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ))
              ),
              child: const Icon(Icons.skip_next_sharp, color: Colors.white, size: 50,)
            ),
          ),
        ],
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final Function() onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll<Color>(AppColors.playButtonColor),
          minimumSize: const WidgetStatePropertyAll<Size>(Size(20,70)),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ))
        ),
        icon: icon
      ),
    );
  }
}
