import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ScaffoldHolder {
  ScaffoldHolder(@factoryParam String keyName)
      : scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: keyName);

  final GlobalKey<ScaffoldState> scaffoldKey;
}
