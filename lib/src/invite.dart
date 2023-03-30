import 'package:mineral/core/extras.dart';
import 'package:mineral_contract/mineral_contract.dart';
import 'package:mineral_invite/src/events/guild_create.dart';

import 'entities/guild_invite_cache.dart';
import 'events/member_add.dart';

class MineralInvitationsModule extends MineralPackageContract with Container {
  MineralInvitationsModule (): super('InvitationsMineral', "Le module d'invitation");
  final GuildInviteCache inviteCache = GuildInviteCache();

  @override
  Future<void> init () async {
    commands.register([]);
    events.register([
      GuildCreate(),
      MineralInviteMemberJoin()
    ]);
    contextMenus.register([]);
    states.register([]);
  }
}