import 'package:mwwm_template/config/build_types.dart';
import 'package:mwwm_template/config/config.dart';
import 'package:mwwm_template/config/env/env.dart';
import 'package:mwwm_template/domain/debug_options.dart';
import 'package:mwwm_template/interactor/common/urls.dart';
import 'package:mwwm_template/runner/runner.dart';

//Main entry point of app
void main() {
  Environment.init(
    buildType: BuildType.release,
    config: Config(
      url: Url.prodUrl,
      proxyUrl: Url.prodProxyUrl,
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
