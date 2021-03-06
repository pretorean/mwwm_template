import 'package:mwwm_template/domain/counter.dart';
import 'package:mwwm_template/util/sp_helper.dart';

class CounterRepository {
  CounterRepository(this._preferencesHelper);

  static const String keyCounter = 'KEY_COUNTER';

  final PreferencesHelper _preferencesHelper;

  void setCounter(Counter c) {
    if (c == null) return;
    _preferencesHelper.set(keyCounter, c.count);
  }

  Future<Counter> getCounter() {
    return _preferencesHelper
        .get(keyCounter, 0)
        .then(
          (i) => Counter(i ?? 0),
        )
        .catchError(
      (Object e) {
        return Counter(0);
      },
    );
  }
}
