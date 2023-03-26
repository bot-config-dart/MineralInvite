import 'package:mineral/core/events.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/src/api/invites/invite.dart';

class InviteMemberAdd extends Event {
  MemberJoinEvent _joinEvent;
  Invite? _invite;
  bool isVanity;

  InviteMemberAdd(this._joinEvent, this._invite, {this.isVanity = false});

  MemberJoinEvent get joinEvent => _joinEvent;

  Invite? get invite => _invite;
}
