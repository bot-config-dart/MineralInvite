import 'package:mineral/core.dart';
import 'package:mineral/core/api.dart';
import 'package:mineral/src/internal/websockets/sharding/shard_manager.dart';
import 'package:mineral_ioc/ioc.dart';

class MusicVoiceChannel extends VoiceChannel {
  MusicVoiceChannel(super.bitrate, super.userLimit, super.rtcRegion, super.videoQualityMode, super.nsfw, super.webhooks, super.messages, super.lastMessageId, super.guildId, super.parentId, super.label, super.type, super.position, super.flags, super.permissions, super.id);

  final _shard = ioc.use<ShardManager>();
  Future<void> join() async {
     await _shard.send(OpCode.voiceStateUpdate, {
      'guild_id': guild.id,
      'channel_id': id,
      'self_mute': false,
      'self_deaf': false,
    });
  }

  factory MusicVoiceChannel.fromVoiceChannel(VoiceChannel channel) {
    return MusicVoiceChannel(
      channel.bitrate,
      channel.userLimit,
      channel.rtcRegion,
      channel.videoQualityMode,
      channel.isNsfw,
      channel.webhooks,
      channel.messages,
      channel.lastMessage?.id,
      channel.guild.id,
      channel.parent?.id,
      channel.label,
      channel.type.value,
      channel.position,
      0,
      channel.permissions,
      channel.id,
    );
  }
}