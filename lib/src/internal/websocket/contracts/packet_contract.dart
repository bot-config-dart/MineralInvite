import 'package:mineral_music/src/internal/websocket/entities/response.dart';

abstract class PacketContract {
  Future<void> handle(WsResponse wsResponse);
}