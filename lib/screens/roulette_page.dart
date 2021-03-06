import 'package:flutter/material.dart';
import 'package:pregnancy_app/screens/prize_page.dart';
import 'package:video_player/video_player.dart';

import '../src/widget_animator.dart';

class Roulette extends StatefulWidget {
  const Roulette({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  late VideoPlayerController controller;
  bool canClaimPrize = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/videos/prize.mp4');

    controller.addListener(() {
      if (controller.value.position.inSeconds > 13.5) {
        setState(() {
          canClaimPrize = true;
        });
      }
    });
    controller.setLooping(false);

    controller.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
            child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: controller.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      if (!canClaimPrize) {
                        controller.play();
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                PrizePage(name: widget.name)));
                      }
                    },
                    child: WidgetAnimator(child: VideoPlayer(controller)))
                : Container(),
          ),
        )),
      ),
    );
  }
}
