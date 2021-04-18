import './state_provider.dart';
import 'dart:async';

class StateBloc {
  StreamController animController = StreamController();
  final StateProvider provider = StateProvider();

  Stream get animationStatus => animController.stream;

  void toggleAnimtion() {
    provider.toggleAnimationValue();
    animController.sink.add(provider.isAnimating);
  }

  void dispose() {
    animController.close();
  }
}

final stateBloc = StateBloc();
