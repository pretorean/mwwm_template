import 'package:mwwm_template/domain/counter.dart';
import 'package:mwwm_template/interactor/counter/repository/counter_repository.dart';
import 'package:rxdart/rxdart.dart';

class CounterInteractor {
  CounterInteractor(this._counterRepository) {
    _subject.listen(_counterRepository.setCounter);

    _counterRepository.getCounter().then((c) {
      _counter = c;
      _subject.add(_counter);
    });
  }

  Counter _counter;

  final CounterRepository _counterRepository;

  final _subject = PublishSubject<Counter>();

  Stream<Counter> get counterObservable => _subject.stream;

  void incrementCounter() {
    final c = _counter.count + 1;
    _counter = Counter(c);
    _subject.add(_counter);
  }
}
