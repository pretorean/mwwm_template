import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mwwm_template/di/di_container.config.dart';

/// main di instance
final getIt = GetIt.instance;

/// main point to initialize di
@InjectableInit(generateForDir: ['lib'])
void configureDependencies() => $initGetIt(getIt);
