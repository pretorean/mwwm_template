// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mwwm/mwwm.dart';

import '../ui/app/app_wm.dart';
import '../interactor/counter/counter_interactor.dart';
import '../ui/base/owners/snackbar_owner.dart';
import '../ui/base/default_dialog_controller.dart';
import '../ui/base/owners/dialog_owner.dart';
import '../ui/base/material_message_controller.dart';
import '../interactor/session/session_changed_interactor.dart';
import '../ui/screen/splash_screen/splash_wm.dart';
import '../ui/base/error/standard_error_handler.dart';
import '../ui/screen/welcome_screen/welcome_screen_wm.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factoryParam<AppWidgetModel, BuildContext, AppParam>(
      (context, value) => AppWidgetModel(context, value));
  gh.factoryParam<DefaultDialogController, GlobalKey<ScaffoldState>, dynamic>(
      (_scaffoldKey, _) => DefaultDialogController(_scaffoldKey,
          dialogOwner: get<DialogOwner>()));
  gh.factoryParam<MaterialMessageController, GlobalKey<ScaffoldState>, dynamic>(
      (_scaffoldState, _) => MaterialMessageController(_scaffoldState,
          snackOwner: get<CustomSnackBarOwner>()));
  gh.factoryParam<SplashScreenWidgetModel, BuildContext, SplashScreenParam>(
      (context, value) => SplashScreenWidgetModel(context, value));
  gh.factory<StandardErrorHandler>(() => StandardErrorHandler(
        get<MessageController>(),
        get<DialogController>(),
        get<SessionChangedInteractor>(),
      ));
  gh.factoryParam<WelcomeScreenWidgetModel, BuildContext, WelcomeScreenParam>(
      (context, value) => WelcomeScreenWidgetModel(
            context,
            value,
            get<CounterInteractor>(),
          ));
  return get;
}
