import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral_invite/src/mixins/invite.dart';

class InviteDelete extends MineralEvent<InviteDeleteEvent> with InvitesMineral, Container {
  @override
  Future<void> handle(event) async {
    final cachedInvites = invitesCache.invites.getOrFail(event.invite?.guild.id);
    cachedInvites.invites.remove(event.invite?.code);
  }
}
