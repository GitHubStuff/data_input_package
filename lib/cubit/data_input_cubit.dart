// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../widget/widget_types.dart';

part 'data_input_state.dart';
part 'data_input_states.dart';

class DataInputCubit extends Cubit<DataInputState> {
  bool _obscureState = true;

  DataInputType _dataInputType;
  DataInputCubit() : super(DataInputInitial());

  // ignore: missing_return
  GestureDetector gestureDetector() {
    assert(_dataInputType != null);
    switch (_dataInputType) {
      case DataInputType.PasswordInput:
        return _passwordInput();
      case DataInputType.TextInput:
        return _textInput();
    }
  }

  void initialState({@required DataInputType dataInputType}) async {
    _dataInputType = dataInputType;
    _obscureState = (_dataInputType == DataInputType.PasswordInput);
    await Future.delayed(Duration(milliseconds: 100));
    emit(InputReadyState(_obscureState));
  }

  void clearText() {
    emit(ClearInputState());
  }

  // ignore: missing_return
  GestureDetector _passwordInput() {
    return GestureDetector(
      child: Icon(
        _obscureState ? Icons.visibility : Icons.visibility_off,
        size: 34.0,
      ),
      onTapDown: (_) => _setObscuredText(false, Duration(milliseconds: 5), 'TD'),
      onTapUp: (_) => _setObscuredText(true, Duration(seconds: 1), 'TU'),
      onTapCancel: () => _setObscuredText(true, Duration(milliseconds: 1), 'TC'),
      onPanEnd: (detail) => debugPrint('On Pan End'),
      onDoubleTap: () => _setObscuredText(!_obscureState, Duration(milliseconds: 1), 'DT'),
      onLongPressStart: (detail) => _setObscuredText(false, Duration(milliseconds: 5), 'LS'),
      onLongPressEnd: (detail) => _setObscuredText(true, Duration(milliseconds: 750), 'LE'),
    );
  }

  void _setObscuredText(bool state, Duration pause, String tag) async {
    Future.delayed(pause ?? Duration(milliseconds: 250), () {
      _obscureState = state;
      emit(ObscureTextState(state));
    });
  }

  GestureDetector _textInput() {
    return GestureDetector(
      child: Icon(
        Icons.cancel,
        size: 34.0,
      ),
      onTapDown: (_) => clearText(),
      onTapUp: (_) => clearText(),
      onTapCancel: () => debugPrint('onTapCancel'),
      onPanEnd: (detail) => debugPrint('On Pan End'),
      onDoubleTap: () => clearText(),
      onLongPressStart: (detail) => clearText(),
      onLongPressEnd: (detail) => clearText(),
    );
  }
}
