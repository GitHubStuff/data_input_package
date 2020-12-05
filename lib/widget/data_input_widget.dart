import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/data_input_cubit.dart';

import 'observing_stateful_widget.dart';

class DataInputWidget extends StatefulWidget {
  final Function(String) callback;
  final Function(String) completion;
  final TextStyle textStyle;
  const DataInputWidget({
    Key key,
    @required this.callback,
    @required this.completion,
    this.textStyle,
  }) : super(key: key);
  @override
  _DataInputWidget createState() => _DataInputWidget();
}

class _DataInputWidget extends ObservingStatefulWidget<DataInputWidget> {
  TextEditingController _textEditingController = TextEditingController();
  DataInputCubit _passwordCubit;
  bool _shouldObscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordCubit = DataInputCubit();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ?? TextStyle(fontSize: 24.0);
    return BlocBuilder<DataInputCubit, DataInputState>(
      cubit: _passwordCubit,
      builder: (context, passwordState) {
        debugPrint('STATE: $passwordState');
        switch (passwordState.buildState) {
          case DataInputBuildState.ObscureTextState:
            _shouldObscureText = (passwordState as ObscureTextState).state;
            break;
          case DataInputBuildState.DataInputInitial:
            break;
        }
        return Focus(
            child: TextField(
              autocorrect: false,
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: _passwordCubit.gestureDetector(),
                contentPadding: EdgeInsets.all(8.0),
              ),
              enableSuggestions: false,
              obscureText: _shouldObscureText,
              onChanged: (text) {
                if (widget.callback is Function) widget.callback(text);
              },
              style: textStyle,
            ),
            onFocusChange: (hasFocus) {
              debugPrint('FOCUS $hasFocus');
              if (!hasFocus && widget.completion is Function) widget.completion(_textEditingController.text);
            });
      },
    );
  }

  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
