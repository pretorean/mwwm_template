// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../ui/app/app_wm.dart';
import '../interactor/counter/counter_interactor.dart';
import '../util/scaffold_holder.dart';
import '../ui/screen/splash_screen/splash_wm.dart';
import '../ui/screen/welcome_screen/welcome_screen_wm.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factoryParam<AppWidgetModel, AppParam, dynamic>(
      (value, _) => AppWidgetModel(value));
  gh.factoryParam<ScaffoldHolder, String, dynamic>(
      (keyName, _) => ScaffoldHolder(keyName));
  gh.factoryParam<SplashScreenWidgetModel, SplashScreenParam, dynamic>(
      (value, _) => SplashScreenWidgetModel(value));
  gh.factoryParam<WelcomeScreenWidgetModel, WelcomeScreenParam, dynamic>(
      (value, _) => WelcomeScreenWidgetModel(value, get<CounterInteractor>()));
  return get;
}
