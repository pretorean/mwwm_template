import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:mwwm_template/ui/app/app.dart';
import 'package:mwwm_template/ui/screen/splash_screen/di/splash_screen_component.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для WelcomeScreenWidgetModel.
SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  final component = Injector.of<SplashScreenComponent>(context).component;

  return SplashScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
  );
}

/// [WidgetModel] для экрана <SplashScreen>
class SplashScreenWidgetModel extends WidgetModel {
  SplashScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  ) : super(dependencies);

  final widgets.NavigatorState _navigator;

  @override
  void onLoad() {
    super.onLoad();
    _loadApp();
  }

  void _loadApp() {
    subscribeHandleError<bool>(
      initApp(),
      (isAuth) {
        _openScreen(AppRouter.root);
      },
    );
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  Stream<bool> initApp() {
    return Stream.value(true).delay(const Duration(seconds: 2));
  }
}
