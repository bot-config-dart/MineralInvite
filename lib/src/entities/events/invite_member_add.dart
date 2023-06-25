import 'package:mineral/core/api.dart';
import 'package:mineral/core/events.dart';
import 'package:mineral/framework.dart';
import 'package:mineral/src/api/invites/invite.dart';

class InviteMemberAdd extends Event {
  MemberJoinEvent joinEvent;
  Invite? invite;
  VanityInvite? vanityInvite;
  bool isVanity;

  InviteMemberAdd(this.joinEvent, this.invite, {this.isVanity = false, this.vanityInvite});
}

