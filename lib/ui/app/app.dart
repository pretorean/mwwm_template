import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm_template/config/config.dart';
import 'package:mwwm_template/config/env/env.dart';
import 'package:mwwm_template/domain/debug_options.dart';
import 'package:mwwm_template/ui/app/app_wm.dart';
import 'package:mwwm_template/ui/base/default_wm_builder.dart';
import 'package:mwwm_template/ui/res/styles.dart';
import 'package:mwwm_template/ui/screen/splash_screen/splash_route.dart';
import 'package:mwwm_template/ui/screen/welcome_screen/welcome_route.dart';
import 'package:mwwm_template/util/error_widget.dart' as error_widget;
import 'package:surf_mwwm/surf_mwwm.dart';

// todo оставить здесь только необходимые маршруты
class AppRouter {
  static const String root = '/';
  static const String splashScreen = '/splash';

  static final Map<String, Route Function(Object)> routes = {
    AppRouter.root: (data) => WelcomeScreenRoute(),
    AppRouter.splashScreen: (data) => SplashScreenRoute(),
  };
}

/// Виджет приложения
class App extends CoreMwwmWidget {
  App({Key key})
      : super(
          key: key,
          widgetModelBuilder: defaultWmBuilder<AppWidgetModel, AppParam>(),
        );

  @override
  _AppState createState() => _AppState();
}

class _AppState extends WidgetState<AppWidgetModel> {
  @override
  void initState() {
    super.initState();
    Environment<Config>.instance().addListener(_setStateOnChangeConfig);
  }

  @override
  void dispose() {
    Environment<Config>.instance().removeListener(_setStateOnChangeConfig);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: wm.navigatorKey,
      builder: (context, widget) {
        ErrorWidget.builder = (flutterErrorDetails) {
          return error_widget.ErrorWidget(
            context: context,
            error: flutterErrorDetails,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            errorMessage: 'test',
          );
        };
        return widget;
      },
      theme: themeData,
      showPerformanceOverlay: getDebugConfig().showPerformanceOverlay,
      debugShowMaterialGrid: getDebugConfig().debugShowMaterialGrid,
      checkerboardRasterCacheImages:
          getDebugConfig().checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: getDebugConfig().checkerboardOffscreenLayers,
      showSemanticsDebugger: getDebugConfig().showSemanticsDebugger,
      debugShowCheckedModeBanner: getDebugConfig().debugShowCheckedModeBanner,
      initialRoute: AppRouter.splashScreen,
      onGenerateRoute: (routeSettings) =>
          AppRouter.routes[routeSettings.name](routeSettings.arguments),
    );
  }

  void _setStateOnChangeConfig() {
    setState(() {});
  }

  DebugOptions getDebugConfig() {
    return Environment<Config>.instance().config.debugOptions;
  }
}
