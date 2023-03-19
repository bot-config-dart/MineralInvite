import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/internal.dart';
import 'package:mineral/src/internal/services/event_service.dart';
import 'package:mineral/src/internal/websockets/websocket_packet.dart';

class VoiceStateUpdate with Container implements WebsocketPacket {
  @override
  Future<void> handle(WebsocketResponse websocketResponse) async {
    EventService manager = container.use<EventService>();
    MineralClient client = container.use<MineralClient>();

    dynamic payload = websocketResponse.payload;

    print(payload);

    /*Guild? guild = client.guilds.cache.get(payload['guild_id']);
    ModerationRule? moderationRule = guild?.moderationRules.cache.get(payload['id']);

    if (moderationRule != null) {
      manager.controller.add(ModerationRulesDeleteEvent(moderationRule));
      guild?.moderationRules.cache.remove(moderationRule.id);
    }*/
  }
}