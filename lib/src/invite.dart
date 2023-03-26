import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral_invite/src/events/guild_create.dart';

import 'entities/guild_invite_cache.dart';
import 'events/member_add.dart';

class MineralInvitationsModule extends MineralModule with Container {
  MineralInvitationsModule (): super('InvitationsMineralSnakeCase', 'InvitationsMineral', "Le module d'invitation");

  @override
  Future<void> init () async {
    container.bind((_) => GuildInviteCache());

    commands.register([]);
    events.register([
      GuildCreate(),
      MineralInviteMemberJoin()
    ]);
    contextMenus.register([]);
    states.register([]);
  }
}