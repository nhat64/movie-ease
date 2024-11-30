import 'package:base_flutter/app/base/mvvm/view/base_screen.dart';
import 'package:base_flutter/presentation/module/movies/play_trailer/play_trailer_controller.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayTrailerPage extends BaseScreen<PlayTrailerController> {
  const PlayTrailerPage({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: controller.youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {},
            controlsTimeOut: const Duration(seconds: 3),
            actionsPadding: const EdgeInsets.all(8),
            bottomActions: const [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
              ),
              RemainingDuration(),
              PlaybackSpeedButton(),
            ],
          ),
          builder: (context, player) {
            return Column(
              children: [
                player,
              ],
            );
          },
        ),
      ],
    );
  }
}
