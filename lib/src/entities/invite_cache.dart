
import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/src/api/invites/invite.dart';

class InviteCache with Container, MineralContext {
  Map<String, Invite> _invites = {};
  final Guild guild;

  InviteCache({required this.guild});

  Map<String, Invite> get invites => _invites;

  Future<void> init() async {
    final invites = await guild.invites.sync();
    for (Invite invite in invites.values) {
        _invites.putIfAbsent(invite.code, () => invite);
    }
  }
}
