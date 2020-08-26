import 'package:flutter/material.dart' hide Action;
import 'package:injectable/injectable.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_template/ui/base/injectable_wm.dart';

class AppParam {}

/// [WidgetModel] для виджета приложения
@injectable
class AppWidgetModel extends InjectableWM<AppParam> {
  AppWidgetModel(
    @factoryParam BuildContext context,
    @factoryParam AppParam value,
  ) : super(context, value);

  final navigatorKey = GlobalKey<NavigatorState>();

}
