// ignore: import_of_legacy_library_into_null_safe
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wooden_fish/model/storage.dart';
import 'package:wooden_fish/model/constant.dart';

class FoZhu extends StatefulWidget {
  const FoZhu({Key? key}) : super(key: key);

  @override
  State<FoZhu> createState() => _FoZhuState();
}

class _FoZhuState extends State<FoZhu> {
  late final AudioPlayer audioPlayer;
  int count = 0;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    getData();
  }

  getData() async {
    int s = await Storage.getInt(Constant.countKey);
    setState(() {
      count = s;
    });
  }

  @override
  void dispose() {
    audioPlayer.pause();
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Image(
              image: AssetImage('assets/fz.png'),
              fit: BoxFit.cover,
            )),
        Positioned(
            top: 120.0,
            left: 0,
            right: 0,
            bottom: 100.0,
            child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return const Image(
                    image: AssetImage('assets/fz-3.png'),
                    width: 10.0,
                    height: 10.0,
                  );
                },
                onIndexChanged: (res) {
                  setState(() {
                    count += 1;
                    Storage.setInt(Constant.countKey, count);
                  });
                  audioPlayer?.play(
                      "https://unwatermarker.cn/woodenFish/audio/sound.mp3");
                },
                autoplay: false,
                itemCount: 3,
                viewportFraction: 0.08,
                scrollDirection: Axis.vertical)),
        Positioned(
            right: 0,
            left: 0,
            top: 60.0,
            child: Text(
              "功德+$count",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            )),
        Positioned(
            left: 20.0,
            top: 60.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Image(
                image: AssetImage('assets/fanhui.png'),
                width: 20.0,
              ),
            )),
      ],
    ));
  }
}
