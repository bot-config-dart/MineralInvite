import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral_invite/src/mixins/invite.dart';

class InviteCreate extends MineralEvent<InviteCreateEvent> with InvitesMineral, Container {
  Future<void> handle(event) async {
    final cachedInvites = invitesCache.invites.getOrFail(event.invite.guild.id);
    cachedInvites.invites.putIfAbsent(event.invite.code, () => event.invite);
  }
}
