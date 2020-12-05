import 'package:bloc/bloc.dart';
import '../widget/widget_types.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'data_input_state.dart';
part 'data_input_states.dart';

class DataInputCubit extends Cubit<DataInputState> {
  DataInputCubit() : super(DataInputInitial());

  bool _obscureState = true;
  DataInputType _dataInputType;

  void initialState({@required DataInputType dataInputType}) async {
    _dataInputType = dataInputType;
    _obscureState = (_dataInputType == DataInputType.PasswordInput);
    await Future.delayed(Duration(milliseconds: 100));
    emit(InputReadyState(_obscureState));
  }

  void _clearText() {
    emit(ClearInputState());
  }

  void _setObscuredText(bool state, Duration pause, String tag) async {
    debugPrint('tag: $tag');
    Future.delayed(pause ?? Duration(milliseconds: 250), () {
      _obscureState = state;
      emit(ObscureTextState(state));
    });
  }

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

  GestureDetector _textInput() {
    return GestureDetector(
      child: Icon(
        Icons.cancel,
        size: 34.0,
      ),
      onTapDown: (_) => _clearText(),
      onTapUp: (_) => _clearText(),
      onTapCancel: () => debugPrint('onTapCancel'),
      onPanEnd: (detail) => debugPrint('On Pan End'),
      onDoubleTap: () => _clearText(),
      onLongPressStart: (detail) => _clearText(),
      onLongPressEnd: (detail) => _clearText(),
    );
  }
}
