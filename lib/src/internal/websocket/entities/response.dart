import 'dart:convert';

class WsResponse {
  String? type;
  int op;
  int? sequence;
  dynamic payload;

  WsResponse({ required this.op, required this.payload, this.type, this.sequence });

  factory WsResponse.from(String socket) {
    dynamic json = jsonDecode(socket);

    return WsResponse(
      type: json['t'],
      op: json['op'],
      sequence: json['s'],
      payload: json['d'],
    );
  }
}