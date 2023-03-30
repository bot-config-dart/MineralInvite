import 'package:mineral_invite/mineral_invite.dart';
import 'package:mineral_invite/src/entities/guild_invite_cache.dart';
import 'package:mineral_ioc/ioc.dart';

mixin InvitesMineral {
  GuildInviteCache get invitesCache => ioc.use<MineralInvitationsModule>().inviteCache;
}