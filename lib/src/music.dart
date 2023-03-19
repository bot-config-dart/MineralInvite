import 'package:mineral/core/extras.dart';
import 'package:mineral_music/src/contracts/music_contract.dart';
import 'package:mineral_music/src/internal/websocket/dispatcher.dart';
import 'package:mineral_package/mineral_package.dart';

class MineralMusic extends MineralPackage with Container implements MusicContract  {
  @override
  String namespace = 'Mineral/Plugins/Music';

  @override
  String label = 'Music';

  @override
  String description = 'The SqliteOrm module was designed exclusively for the Mineral framework, it allows you to communicate with a SqliteOrm database file.';

  MineralMusic();

  @override
  Future<void> init() async {
    Dispatcher();


  }
}
