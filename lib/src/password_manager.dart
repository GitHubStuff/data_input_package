import 'dart:async';

import 'package:flutter/material.dart';

enum PasswordState {
  show,
  hide,
  cancel,
  longPressDown,
  longPressUp,
}

class PasswordItem {
  PasswordState _passwordState;
  bool _passwordSelection;
  PasswordItem() {
    _passwordState = PasswordState.hide;
    _passwordSelection = true;
  }
  bool get obscureText => !(_passwordState == PasswordState.show || _passwordState == PasswordState.longPressDown);
  bool get passwordSelection => _passwordSelection;

  @override
  String toString() {
    return 'State: ${_passwordState.toString()} Selection: ${_passwordSelection.toString()}';
  }
}

class PasswordManager {
  // ignore: close_sinks
  final _controller = StreamController<PasswordItem>();
  final _passwordItem = PasswordItem();

  Stream<PasswordItem> get stream => _controller.stream.asBroadcastStream();

  void updateState(PasswordState state) {
    debugPrint('New State: ${state.toString()} OldState: ${_passwordItem.toString()}');
    int duration = 0;
    switch (state) {
      case PasswordState.cancel:
        duration = 1;
        _passwordItem._passwordState = PasswordState.hide;
        break;
      case PasswordState.hide:
        _passwordItem._passwordState = PasswordState.hide;
        break;
      case PasswordState.longPressDown:
        if (_passwordItem._passwordState == PasswordState.longPressDown) return;
        _passwordItem._passwordState = PasswordState.longPressDown;
        return;
      case PasswordState.longPressUp:
        _passwordItem._passwordState = PasswordState.hide;
        break;
      case PasswordState.show:
        _passwordItem._passwordState = PasswordState.show;
        break;
    }
    debugPrint('Duration $duration New State: ${state.toString()} OldState: ${_passwordItem.toString()}');
    Timer(Duration(seconds: duration), () {
      _controller.sink.add(_passwordItem);
    });
  }

  void updateSelectable({String content}) {
    debugPrint('Content: $content');
    _passwordItem._passwordSelection = content.isEmpty;
    _passwordItem._passwordState = PasswordState.hide;
    _controller.sink.add(_passwordItem);
  }
}
