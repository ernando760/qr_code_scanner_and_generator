import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

class BaseController<T> extends ChangeNotifier {
  T _state;
  BaseController(this._state);

  T get state => _state;

  void updateState(T newState) {
    _state = newState;
    notifyListeners();
  }
}

class BaseStateController<S extends BaseState> extends BaseController<S> {
  BaseStateController(super.state);
}
