import 'dart:async';

import 'package:mineral/core.dart';
import 'package:mineral_music/mineral_music.dart';

class HearthBeatMusic {
  final Duration interval;
  final MusicWebsocket websocket;
  late Timer timer;

  HearthBeatMusic(this.interval, this.websocket);

  Future<void> start() async {
    timer = Timer.periodic(interval, (timer) async {
      await websocket.send(OpCode.heartbeat, {});
      print("heartbeat");
    });
  }

  Future<void> disconnect() async {
    // todo
  }
}
