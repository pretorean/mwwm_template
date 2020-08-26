import 'package:mwwm_template/di/di_container.dart';

Function defaultWmBuilder<T, I>({I value}) {
  return (context) {
    return getIt.get<T>(param1: context, param2: value);
  };
}
