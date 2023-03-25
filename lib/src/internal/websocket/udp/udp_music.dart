import 'package:mineral_music/src/internal/websocket/udp/voice_type_music.dart';
import 'package:mineral_music/src/internal/websocket/websocket_music.dart';
import 'package:udp/udp.dart';

class UdpMusic {
    late UDP udp;
    final Endpoint endpoint;
    final MusicWebsocket websocket;

    UdpMusic({ required this.endpoint, required this.websocket });

    Future<UDP> connect() async {
        udp = await UDP.bind(endpoint);

        print(udp.socket?.address.address);
        print(udp.socket?.port.toInt());
        await websocket.send(VoiceOpCode.selectProtocol, {
            "protocol": "udp",
            "data": {
              "address": udp.socket?.address.address,
              "port": udp.socket?.port.toInt(),
              "mode": VoiceTypeMusic.xsalsa.value
            }
          });

        final receive = await UDP.bind(Endpoint.loopback(port: endpoint.port!));

        receive.asStream(timeout: Duration(seconds: 2000)).listen((event) {
          print(event?.data);
        });

        return udp;
    }
}