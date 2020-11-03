import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_template/ui/base/default_dependency_builder.dart';
import 'package:mwwm_template/ui/base/error/standard_error_handler.dart';
import 'package:relation/relation.dart';

/// base class for injectable widget model
class InjectableWM<T> extends WidgetModel {
  ErrorHandler _errorHandler;

  final T value;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  InjectableWM(
    this.value,
  ) : super(WidgetModelDependencies(
            errorHandler: StandardErrorHandler(null, null, null)));

  @protected
  WidgetModelDependencies dependenciesBuilder() {
    return defaultScaffoldDependencyBuilder(scaffoldKey);
  }

  @override
  void onLoad() {
    _errorHandler = dependenciesBuilder().errorHandler;
    super.onLoad();
  }

  @override
  void handleError(e) {
    _errorHandler.handleError(e);
  }

  /// bind ui [Event]'s
  void bind<U>(
    Event<U> event,
    void Function(U t) onValue, {
    void Function(dynamic e) onError,
  }) =>
      subscribe<U>(event.stream, onValue, onError: onError);
}
