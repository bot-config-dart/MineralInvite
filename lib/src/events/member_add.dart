import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral_invite/src/entities/events/invite_member_add.dart';
import 'package:mineral_invite/src/mixins/invite.dart';
import 'package:mineral/src/internal/services/event_service.dart';

class MineralInviteMemberJoin extends MineralEvent<MemberJoinEvent> with InvitesMineral, Container {
  @override
  Future<void> handle(event) async {
      final cachedInvites = invitesCache.invites.getOrFail(event.member.guild.id);
      final invites = await event.member.guild.invites.sync();
      final invite = invites.find((element) => cachedInvites.invites.getOrFail(element.code).uses < element.uses);
      EventService manager = container.use<EventService>();

      manager.controller.add(InviteMemberAdd(event, invite, isVanity: invite?.code.equals(event.member.guild.vanityUrlCode) == null ? false : invite!.code.equals(event.member.guild.vanityUrlCode)));
  }
}
