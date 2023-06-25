import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral_invite/src/entities/invite_cache.dart';
import 'package:mineral_invite/src/mixins/invite.dart';

class GuildCreate extends MineralEvent<GuildCreateEvent> with InvitesMineral, Container {
  @override
  Future<void> handle(event) async {
    Guild guild = event.guild;
    InviteCache cache = InviteCache(guild: guild);

    await cache.sync();
    invitesCache.add(guild, cache);
  }
}
