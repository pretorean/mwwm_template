import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Дефолтный диалог выбора даты
class DatePickerDialogController {
  DatePickerDialogController(this._scaffoldKey)
      : assert(_scaffoldKey != null),
        _context = null;

  DatePickerDialogController.from(this._context)
      : assert(_context != null),
        _scaffoldKey = null;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  final BuildContext _context;

  BuildContext get context => _context ?? _scaffoldKey.currentContext;

  Stream<DateTime> show({
    DateTime firstDate,
    DateTime lastDate,
    DateTime initialDate,
    Widget iosCloseButton,
    Widget iosDoneButton,
  }) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return showDatePicker(
        context: context,
        firstDate: firstDate ?? DateTime(1900),
        initialDate: initialDate,
        lastDate: lastDate ?? DateTime(2090),
      ).asStream();
    } else {
      final controller = StreamController<DateTime>();
      showCupertinoModalPopup<void>(
        context: context,
        builder: (ctx) => _buildBottomPicker(
          CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate ?? DateTime.now(),
            onDateTimeChanged: controller.add,
          ),
          onCancel: () {
            controller
              ..add(initialDate)
              ..close();
            Navigator.of(context, rootNavigator: true).pop();
          },
          onDone: () {
            controller.close();
            Navigator.of(context, rootNavigator: true).pop();
          },
          iosCloseButton: iosCloseButton,
          iosDoneButton: iosDoneButton,
        ),
      );
      return controller.stream;
    }
  }

  Widget _buildBottomPicker(
      Widget picker, {
        VoidCallback onCancel,
        VoidCallback onDone,
        Widget iosCloseButton,
        Widget iosDoneButton,
      }) {
    return Container(
      height: 266,
      color: CupertinoColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              iosCloseButton ??
                  CupertinoButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: onCancel,
                    color: Colors.transparent,
                    child: const Text(
                      'Сбросить',
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                  ),
              iosDoneButton ??
                  CupertinoButton(
                    padding: const EdgeInsets.all(5),
                    onPressed: onDone,
                    color: Colors.transparent,
                    child: const Text(
                      'Готово',
                      style: TextStyle(color: CupertinoColors.activeBlue),
                    ),
                  ),
            ],
          ),
          Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            color: CupertinoColors.white,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: CupertinoColors.black,
                fontSize: 22.0,
              ),
              child: GestureDetector(
                // Blocks taps from propagating to the modal sheet and popping.
                onTap: () {},
                child: SafeArea(
                  top: false,
                  child: picker,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}