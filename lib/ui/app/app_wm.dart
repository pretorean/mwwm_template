import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_template/ui/base/injectable_wm.dart';

class AppParam {}

/// [WidgetModel] для виджета приложения
@injectable
class AppWidgetModel extends InjectableWM<AppParam> {
  AppWidgetModel(
    @factoryParam AppParam value,
  ) : super(value);

  @override
  final navigatorKey = GlobalKey<NavigatorState>();
}
