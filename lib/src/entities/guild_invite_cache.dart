import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral_invite/src/entities/invite_cache.dart';
import 'package:mineral_ioc/ioc.dart';

class GuildInviteCache extends MineralService with Container {
  Map<String, InviteCache> _invites = {};

  Map<String, InviteCache> get invites => _invites;

  void add(Guild guild, InviteCache cache) {
    _invites.putIfAbsent(guild.id, () => cache);
  }

  void remove(Guild guild) {
    _invites.remove(guild.id);
  }
}