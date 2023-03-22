import 'package:mineral_music/src/internal/websocket/websocket_music.dart';
import 'package:udp/udp.dart';

class UdpMusic {
    late UDP udp;
    final Endpoint endpoint;
    final MusicWebsocket websocket;

    UdpMusic({ required this.endpoint, required this.websocket });

    Future<UDP> connect() async {
        udp = await UDP.bind(endpoint);

        print(endpoint.address?.rawAddress);
        print(endpoint.port?.value);
        await websocket.send(VoiceOpCode.selectProtocol, {
            "protocol": "udp",
            "data": {
              "address": endpoint.address?.address,
              "port": endpoint.port?.value,
              "mode": "xsalsa20_poly1305_lite"
            }
          }
        );

        final receive = await UDP.bind(Endpoint.loopback(port: endpoint.port!));

        receive.asStream(timeout: Duration(seconds: 2000)).listen((event) {
          print(event?.data);
        });

        return udp;
    }
}