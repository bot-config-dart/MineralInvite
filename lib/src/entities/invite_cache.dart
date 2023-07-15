
import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';

class InviteCache with Container {
  Map<String, Invite> invites = {};
  VanityInvite? vanityInvite;
  final Guild guild;

  InviteCache({required this.guild});


  Future<void> sync() async {
    invites.clear();
    final invitesSync = await guild.invites.sync();
    for (Invite invite in invitesSync.values) {
        invites.putIfAbsent(invite.code, () => invite);
    }

    if(guild.features.contains(GuildFeature.vanityUrl)) {
      final vanityInviteS = guild.vanity?.code;
      if(vanityInviteS != null) {
        vanityInvite = await VanityInvite.sync(guild.id);
      }
    }
  }
}
