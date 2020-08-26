import 'package:flutter/material.dart';
import 'package:mwwm_template/config/config.dart';
import 'package:mwwm_template/config/env/env.dart';
import 'package:mwwm_template/interactor/counter/counter_interactor.dart';
import 'package:mwwm_template/interactor/counter/repository/counter_repository.dart';
import 'package:mwwm_template/interactor/network/header_builder.dart';
import 'package:mwwm_template/interactor/network/status_mapper.dart';
import 'package:mwwm_template/interactor/session/session_changed_interactor.dart';
import 'package:mwwm_template/interactor/token/token_storage.dart';
import 'package:mwwm_template/util/const.dart';
import 'package:mwwm_template/util/sp_helper.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_network/surf_network.dart';

/// Component per app
class AppComponent implements Component {
  AppComponent(BuildContext context) {
    context.toString();
    rebuildDependencies();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  PreferencesHelper preferencesHelper = PreferencesHelper();
  AuthInfoStorage authStorage;
  RxHttp http;
  SessionChangedInteractor scInteractor;
  CounterInteractor counterInteractor;

  void rebuildDependencies() {
    _initDependencies();
  }

  void _initDependencies() {
    authStorage = AuthInfoStorage(preferencesHelper);
    http = _initHttp(authStorage);
    scInteractor = SessionChangedInteractor(authStorage);

    counterInteractor = CounterInteractor(
      CounterRepository(preferencesHelper),
    );
  }

  RxHttp _initHttp(AuthInfoStorage authStorage) {
    final proxyUrl = Environment<Config>.instance().config.proxyUrl;
    final dioHttp = DioHttp(
      config: HttpConfig(
        emptyString,
        const Duration(seconds: 30),
        proxyUrl: proxyUrl,
      ),
      errorMapper: DefaultStatusMapper(),
      headersBuilder: DefaultHeaderBuilder(authStorage),
    );
    return RxHttpDelegate(dioHttp);
  }
}
