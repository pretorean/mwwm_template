import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm_template/ui/app/app.dart';

Future<void> run() async {
  // Нужно вызывать чтобы не падало проставление ориентации
  WidgetsFlutterBinding.ensureInitialized();
  // закрепляем ориентацию todo изменить на необходимое или убрать
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  _initCrashlytics();
  _initLogger();
  _runApp();
}

void _runApp() {
//  runZonedGuarded<Future<void>>(
//    () async {
  runApp(App());
//    },
//    Crashlytics.instance.recordError,
//  );
}

void _initCrashlytics() {
//  Crashlytics.instance.enableInDevMode = false;
//  FlutterError.onError = Crashlytics.instance.recordFlutterError;
}

void _initLogger() {
//  RemoteLogger.addStrategy(CrashlyticsRemoteLogStrategy());
//  Logger.addStrategy(DebugLogStrategy());
//  Logger.addStrategy(RemoteLogStrategy());
}
