import 'package:mineral_invite/src/entities/guild_invite_cache.dart';
import 'package:mineral_ioc/ioc.dart';

mixin InvitesMineral {
  GuildInviteCache get invitesCache => ioc.use<GuildInviteCache>();
}