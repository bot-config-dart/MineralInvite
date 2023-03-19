
import 'dart:convert';
import 'dart:io';

import 'package:mineral/core.dart';
import 'package:mineral/core/api.dart';
import 'package:mineral/internal.dart';
import 'package:mineral_ioc/ioc.dart';

import 'dispatcher.dart';
import 'hearthbeat.dart';

class MusicWebsocket extends MineralService {
  final String _url;
  final String _token;
  final String _sessionId;
  final String _guildId;
  late WebSocket _websocket;
  late MineralClient _client;
  late Dispatcher _dispatcher;
  late HearthBeatMusic _hearthBeat;

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

    await send(OpCode.identify, {
      "server_id": _guildId,
      "user_id": _client.user.id,
      "session_id": _sessionId,
      "token": _token
    });

    _websocket.listen((event) async {
      dynamic payload = json.decode(event);
      OpCode code = OpCode.values.firstWhere((element) => element.index == payload['op']);
      print(payload);
      switch(code)  {
        case OpCode.dispatch:
          _dispatcher.dispatch(WebsocketResponse.from(payload));
          break;
        case OpCode.hello:
          send(OpCode.heartbeat, {});
          break;
        case OpCode.requestGuildMember:
          double interval = payload['d']['heartbeat_interval'];
          _hearthBeat = HearthBeatMusic(Duration(seconds: interval.toInt()), this);
          await _hearthBeat.start();
          break;
      }
    });

    ioc.bind<MusicWebsocket>((ioc) => this);
  }

  Future<void> disconnect() async {
    await _websocket.close();
  }

  Future<void> send(OpCode code, Map<String, dynamic> data) async {
    _websocket.add('{"op": ${code.index}, "d": ${json.encode(data)}}');
  }
}