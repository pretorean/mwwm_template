import 'package:injectable/injectable.dart';
import 'package:mwwm_template/domain/counter.dart';
import 'package:mwwm_template/interactor/counter/counter_interactor.dart';
import 'package:mwwm_template/ui/base/injectable_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class WelcomeScreenParam {}

/// [WidgetModel] для экрана <Welcome>
@injectable
class WelcomeScreenWidgetModel extends InjectableWM<WelcomeScreenParam> {
  WelcomeScreenWidgetModel(
    @factoryParam WelcomeScreenParam value,
    this._counterInteractor,
  ) : super(value);

  final CounterInteractor _counterInteractor;

  StreamedState<int> counterState = StreamedState();

  Action nextAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    _listenToStreams();
  }

  void _listenToStreams() {
    _listenToActions();

    subscribe<Counter>(
      _counterInteractor.counterObservable,
      (c) => counterState.accept(c.count),
    );
  }

  void _listenToActions() {
    bind<void>(
      nextAction,
      (_) {
        _counterInteractor.incrementCounter();
      },
    );
  }
}
