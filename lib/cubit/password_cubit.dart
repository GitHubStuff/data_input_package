import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'password_state.dart';
part 'password_states.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitial());

  bool _obscureState = true;

  void _setObscuredText(bool state, Duration pause, String tag) async {
    debugPrint('tag: $tag');
    Future.delayed(pause ?? Duration(milliseconds: 250), () {
      _obscureState = state;
      emit(ObscureTextState(state));
    });
  }

  GestureDetector gestureDetector() {
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
}
