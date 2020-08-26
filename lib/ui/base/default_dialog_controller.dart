import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_template/ui/base/owners/dialog_owner.dart';
import 'package:mwwm_template/ui/common/dialog/alert_dialog.dart';
import 'package:mwwm_template/util/enum.dart';

/// Типы сообщений
class DialogType extends Enum<String> {
  const DialogType(String value) : super(value);

  static const alert = DialogType('alert');
}

///Стандартная реализация [DialogController]
@injectable
class DefaultDialogController implements DialogController {
  DefaultDialogController(
    @factoryParam this._scaffoldKey, {
    this.dialogOwner,
  })  : assert(_scaffoldKey != null),
        _context = null;

  DefaultDialogController.from(this._context, {this.dialogOwner})
      : assert(_context != null),
        _scaffoldKey = null;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext _context;
  final DialogOwner dialogOwner;

  PersistentBottomSheetController _sheetController;

  BuildContext get context => _context ?? _scaffoldKey.currentContext;

  ScaffoldState get nearestScaffoldState =>
      _scaffoldKey?.currentState ?? Scaffold.of(_context);

  @override
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    onAgreeClicked,
    onDisagreeClicked,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => PlatformAlertDialog(
        alertText: message,
        onAgreeClicked: () => onAgreeClicked(ctx),
        onDisagreeClicked: () => onDisagreeClicked(ctx),
      ),
    );
  }

  /// Создание кастомного диалога
  Future<R> showCustomAlertDialog<R>(Widget alertDialog) {
    return showDialog(context: context, builder: (ctx) => alertDialog);
  }

  @override
  Future<R> showSheet<R>(type, {VoidCallback onDismiss, DialogData data}) {
    assert(dialogOwner != null);

    final buildDialog = dialogOwner.registeredDialogs[type];

    final sheetController = nearestScaffoldState.showBottomSheet<R>(
      (ctx) => buildDialog(ctx, data: data),
    );
    _sheetController = sheetController;

    return sheetController.closed.whenComplete(() {
      _sheetController = null;
      onDismiss?.call();
    });
  }

  Future<R> showFlexibleModalSheet<R>(
    Object type, {
    double minHeight,
    double initHeight,
    double maxHeight,
    bool isCollapsible = true,
    bool isExpand = true,
    bool useRootNavigator = false,
    bool isModal = true,
    List<double> anchors,
    DialogData data,
  }) {
    assert(dialogOwner != null);

    final buildDialog = dialogOwner.registeredDialogs[type]
        as FlexibleDialogBuilder<DialogData>;

    return showFlexibleBottomSheet(
        context: context,
        minHeight: minHeight,
        initHeight: initHeight,
        maxHeight: maxHeight,
        isCollapsible: isCollapsible,
        isExpand: isExpand,
        useRootNavigator: useRootNavigator,
        isModal: isModal,
        anchors: anchors,
        builder: (context, scrollController, offset) {
          return Material(
            child: buildDialog(
              context,
              data: data,
              scrollController: scrollController,
            ),
          );
        });
  }

  void hideBottomSheet() {
    _sheetController?.close();
  }

  @override
  Future<R> showModalSheet<R>(
    type, {
    VoidCallback onDismiss,
    DialogData data,
    bool isScrollControlled = false,
  }) {
    assert(dialogOwner != null);

    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (ctx) => dialogOwner.registeredDialogs[type](ctx, data: data),
    );
  }
}
