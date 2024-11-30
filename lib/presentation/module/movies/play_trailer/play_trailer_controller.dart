import 'package:base_flutter/app/base/mvvm/view_model/base_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayTrailerController extends BaseController {
  final String youtubeLink;

  PlayTrailerController({required this.youtubeLink});

  late YoutubePlayerController youtubeController;

  @override
  void onInit() {
    super.onInit();
    youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(youtubeLink) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void onReady() {}

  @override
  dispose() {
    youtubeController.dispose();
    super.dispose();
  }
}
