# Project for Mineral Bot discord Framework !

## How to install ?

In your pubspec.yaml, add this following code on `dependencies` :

```
  mineral_invite:
    git:
      url: https://github.com/bot-config-dart/MineralInvite
      ref: main
```

## How to use it ?


add `MineralInvitationsModule(),` in modules.register on your main; and use it !

```dart
import 'dart:io';

import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';
import 'package:mineral_invite/mineral_invite.dart';
import 'package:path/path.dart';

class InviteMemberJoin extends MineralEvent<InviteMemberAdd> with MineralContext {
  File settingsFile = File(join(Directory.current.path, "config", "config.yml"));

  Future<void> handle (event) async {
    print(event.invite?.code);
    print(event.joinEvent.member.user.username);
  }
}
```

