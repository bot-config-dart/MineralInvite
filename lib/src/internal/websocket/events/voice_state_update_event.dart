import 'package:mineral/core/api.dart';
import 'package:mineral/framework.dart';

class VoiceStateUpdateEvent extends Event {
  final VoiceChannel _voiceChannel;

  VoiceStateUpdateEvent(this._voiceChannel);

  VoiceChannel get rule => _voiceChannel;
}