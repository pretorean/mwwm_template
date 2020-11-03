import 'package:injectable/injectable.dart';
import 'package:mwwm_template/ui/app/app.dart';
import 'package:mwwm_template/ui/base/injectable_wm.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class SplashScreenParam {}

/// [WidgetModel] для экрана <SplashScreen>
@injectable
class SplashScreenWidgetModel extends InjectableWM<SplashScreenParam> {
  SplashScreenWidgetModel(
    @factoryParam SplashScreenParam value,
  ) : super(value);

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
    navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Stream<bool> initApp() {
    return Stream.value(true).delay(const Duration(seconds: 2));
  }
}
