import 'package:flutter/material.dart';
import 'package:mwwm_template/ui/base/default_wm_builder.dart';
import 'package:mwwm_template/ui/screen/splash_screen/splash_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Splash screen
class SplashScreen extends CoreMwwmWidget {
  SplashScreen({Key key})
      : super(
          key: key,
          widgetModelBuilder:
              defaultWmBuilder<SplashScreenWidgetModel, SplashScreenParam>(),
        );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends WidgetState<SplashScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wm.scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.error_outline,
              size: 150,
              color: Colors.indigo,
            ),
            Text(
              'Add Logo Here', //todo change logo
              style: TextStyle(
                fontSize: 30,
                color: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
