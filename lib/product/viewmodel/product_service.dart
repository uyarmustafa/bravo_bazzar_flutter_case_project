// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../shared_prefrences.dart';


String get accessToken =>
    LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);

String socketUrl='wss://api.bravoshopgo.com/ws/api/v1/?token=$accessToken';

class SocketService{
  static IO.Socket? socket;

  void connected(){
    socket = IO.io(
      socketUrl,
      OptionBuilder()
      .setTransports(['websocket'])
      .disableAutoConnect()
      .build()
    );
    init();
  }

  static void init(){
    socket!.connect();
    socket!.onConnect((data){
      log("Socket is connected",name: "SocketService");
       socket!.emit("service", "46");
    });
  }
}