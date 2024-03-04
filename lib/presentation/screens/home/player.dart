import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:ip/core/consts.dart';
import 'package:lottie/lottie.dart';

import '../../../vlc_player_with_controls.dart';

class Player extends StatefulWidget {
  Player({Key? key, required this.url}) : super(key: key);
  final String url;
  static const networkCachingMs = 3000;
  static const subtitlesFontSize = 30;
  static const ancho = 400.0;
  static const alto = 400.0;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final _key = GlobalKey<VlcPlayerWithControlsState>();

  // ignore: avoid-late-keyword
  late final VlcPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([
          VlcAdvancedOptions.networkCaching(Player.networkCachingMs),
        ]),
        subtitle: VlcSubtitleOptions([
          VlcSubtitleOptions.boldStyle(true),
          VlcSubtitleOptions.fontSize(Player.subtitlesFontSize),
          VlcSubtitleOptions.outlineColor(VlcSubtitleColor.yellow),
          VlcSubtitleOptions.outlineThickness(VlcSubtitleThickness.normal),
          // works only on externally added subtitles
          VlcSubtitleOptions.color(VlcSubtitleColor.navy),
        ]),
        http: VlcHttpOptions([
          VlcHttpOptions.httpReconnect(true),
        ]),
        rtp: VlcRtpOptions([
          VlcRtpOptions.rtpOverRtsp(true),
        ]),
      ),
    );

    _controller.addOnInitListener(() async {
      await _controller.startRendererScanning();
    });
    _controller.addOnRendererEventListener((type, id, name) {
      debugPrint('OnRendererEventListener $type $id $name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: SafeArea(
        child: Material(
          child: SizedBox(
            height: double.infinity, // Player.ancho,
            child: VlcPlayerWithControls(
              key: _key,
              controller: _controller,
              onStopRecording: (recordPath) {
                setState(() {
                  // listVideos.add(
                  //   VideoData(
                  //     name: 'Recorded Video',
                  //     path: recordPath,
                  //     type: VideoType.recorded,
                  //   ),
                  // );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'El archivo de vídeo grabado',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.stopRecording();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }
}
