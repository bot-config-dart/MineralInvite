import 'package:mineral/core/api.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/src/internal/services/event_service.dart';
import 'package:mineral_invite/src/entities/events/invite_member_add.dart';
import 'package:mineral_invite/src/mixins/invite.dart';

import '../../mineral_invite.dart';

class MineralInviteMemberJoin extends MineralEvent<MemberJoinEvent> with InvitesMineral, Container {
  @override
  Future<void> handle(event) async {
    final cachedInvites = invitesCache.invites.getOrFail(event.member.guild.id);
    final invites = await event.member.guild.invites.sync();
    Invite? invite = invites.find((element) => !cachedInvites.invites.containsKey(element) && cachedInvites.invites.get(element.code)!.uses < element.uses);
    EventService manager = container.use<EventService>();

    if (invite == null) {
      VanityInvite? vanityInvite = await VanityInvite.sync(event.member.guild.id);
      print(vanityInvite?.uses);
      print(cachedInvites.vanityInvite?.uses);

      if(event.guild.features.contains(GuildFeature.vanityUrl) && vanityInvite != null && cachedInvites.vanityInvite != null && vanityInvite.uses > cachedInvites.vanityInvite!.uses) {
        manager.controller.add(InviteMemberAdd(event, null, vanityInvite: event.guild.vanity, isVanity: true));
        return;
      }
    }

    await cachedInvites.sync();
    manager.controller.add(InviteMemberAdd(event, invite, isVanity: false));
  }
}
