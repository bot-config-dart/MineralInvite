import 'package:mineral_music/src/internal/websocket/contracts/packet_contract.dart';
import 'package:mineral_music/src/internal/websocket/entities/response.dart';

class Dispatcher {
  final Map<PacketType, PacketContract> _packets = {};

  Dispatcher() {

  }

  void register(PacketType type, PacketContract packet) {
    _packets.putIfAbsent(type, () => packet);
  }

  void dispatch(WsResponse wsResponse) {
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