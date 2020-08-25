import 'package:mwwm_template/util/const.dart';

class PhoneNumberUtil {
  static const String phonePrefix = '7';
  static const String defaultPattern = '+0 (000) 000 00 00';

  /// Возвращает только цифры из номера телефона
  /// 79801234567
  static String normalize(String inputString, {bool withPrefix = false}) {
    final buff = StringBuffer();
    for (var i = 0; i < inputString.length; i++) {
      final o = inputString[i];
      if (int.tryParse(o) != null) {
        buff.write(o);
      }
    }

    var res = emptyString;
    if (withPrefix) {
      res += phonePrefix;
    }
    res += buff.toString();
    return res;
  }
}
