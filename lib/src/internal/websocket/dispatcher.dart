import 'package:mineral/internal.dart';

class Dispatcher {
  final Map<PacketType, WebsocketPacket> _packets = {};

  Dispatcher() {
     // register(PacketType.voiceStateUpdate, ());
  }

  void register(PacketType type, WebsocketPacket packet) {
    _packets.putIfAbsent(type, () => packet);
  }

  void dispatch(WebsocketResponse wsResponse) {
    PacketType packetType = PacketType.values.firstWhere((element) => element.toString() == wsResponse.type);

    if(_packets.containsKey(packetType)) {
      _packets[packetType]?.handle(wsResponse);
    }
  }
}

enum PacketType {
  voiceStateUpdate("VOICE_STATE_UPDATE");

  final String value;
  const PacketType(this.value);
}