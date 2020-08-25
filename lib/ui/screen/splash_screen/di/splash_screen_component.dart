import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_template/ui/app/di/app.dart';
import 'package:mwwm_template/ui/base/default_dialog_controller.dart';
import 'package:mwwm_template/ui/base/error/standard_error_handler.dart';
import 'package:mwwm_template/ui/base/material_message_controller.dart';
import 'package:surf_injector/surf_injector.dart';

/// [Component] для экрана <SplashScreen>
class SplashScreenComponent implements Component {
  SplashScreenComponent(BuildContext context) {
    final app = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    navigator = Navigator.of(context);

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        app.scInteractor,
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MaterialMessageController messageController;
  DefaultDialogController dialogController;
  NavigatorState navigator;
  WidgetModelDependencies wmDependencies;
}
