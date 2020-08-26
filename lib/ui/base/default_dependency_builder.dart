import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_template/di/di_container.dart';
import 'package:mwwm_template/interactor/session/session_changed_interactor.dart';
import 'package:mwwm_template/ui/base/default_dialog_controller.dart';
import 'package:mwwm_template/ui/base/error/standard_error_handler.dart';
import 'package:mwwm_template/ui/base/material_message_controller.dart';

final Function defaultScaffoldDependencyBuilder =
    (GlobalKey<ScaffoldState> scaffoldKey) {
  final messageController = MaterialMessageController(scaffoldKey);
  final dialogController = DefaultDialogController(scaffoldKey);

  return WidgetModelDependencies(
    errorHandler: StandardErrorHandler(
      messageController,
      dialogController,
      getIt.get<SessionChangedInteractor>(),
    ),
  );
};
