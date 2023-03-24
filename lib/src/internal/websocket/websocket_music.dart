import 'dart:convert';
import 'dart:io';

import 'package:mineral/core.dart';
import 'package:mineral/core/api.dart';
import 'package:mineral/internal.dart';
import 'package:mineral_ioc/ioc.dart';
import 'package:mineral_music/src/internal/websocket/udp/udp_music.dart';

import 'dispatcher.dart';
import 'hearthbeat.dart';
import 'package:udp/udp.dart';

class MusicWebsocket extends MineralService {
  final String _url;
  final String _token;
  final String _sessionId;
  final String _guildId;
  late WebSocket _websocket;
  late MineralClient _client;
  late Dispatcher _dispatcher;
  late HearthBeatMusic _hearthBeat;

  //late UDP udp;

  MusicWebsocket(this._url, this._token, this._sessionId, this._guildId) {
    _client = ioc.use<MineralClient>();
  }

  void register() {
    ioc.bind<MusicWebsocket>((ioc) => this);
  }

  // getters
  String get url => _url;

  String get token => _token;

  String get sessionId => _sessionId;

  String get guildId => _guildId;

  Future<void> connect() async {
    _websocket = await WebSocket.connect("wss://$_url?v=4");
    _dispatcher = Dispatcher();

    await send(VoiceOpCode.identify, {
      "server_id": _guildId,
      "user_id": _client.user.id,
      "session_id": _sessionId,
      "token": _token
    });
    ioc.bind<MusicWebsocket>((ioc) => this);

    _websocket.listen((event) async {
      dynamic payload = json.decode(event);
      VoiceOpCode code = VoiceOpCode.values
          .firstWhere((element) => element.index == payload['op']);
      print(payload);
      switch (code) {
        case VoiceOpCode.hello:
          double interval = payload['d']['heartbeat_interval'];
          _hearthBeat =
              HearthBeatMusic(Duration(milliseconds: interval.toInt()), this);
          await _hearthBeat.start();
          await send(
              VoiceOpCode.speaking, {"speaking": 5, "delay": 0, "ssrc": 1});
          UdpMusic udpMusic = UdpMusic(
              endpoint: Endpoint.any(port: Port(6500)), websocket: this);
          await udpMusic.connect();
          break;
      }
    });
  }

  Future<void> disconnect() async {
    await _websocket.close();
  }

  Future<void> send(VoiceOpCode code, Map<String, dynamic> data) async {
    _websocket.add('{"op": ${code.index}, "d": ${json.encode(data)}}');
  }
}

enum VoiceOpCode {
  identify(0),
  selectProtocol(1),
  ready(2),
  heartbeat(3),
  sessionDescription(4),
  speaking(5),
  heartbeatACK(6),
  resume(7),
  hello(8),
  resumed(9),
  disconnect(10);

  final int value;

  const VoiceOpCode(this.value);
}
