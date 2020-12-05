import 'package:data_input_package/widget/widget_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/data_input_cubit.dart';

import 'observing_stateful_widget.dart';

class DataInputWidget extends StatefulWidget {
  final DataInputType dataInputType;
  final Function(String) callback;
  final Function(String) completion;
  final TextStyle textStyle;
  final String hint;
  const DataInputWidget({
    Key key,
    @required this.dataInputType,
    @required this.callback,
    @required this.completion,
    this.hint,
    this.textStyle,
  })  : assert(dataInputType != null),
        super(key: key);
  @override
  _DataInputWidget createState() => _DataInputWidget();
}

class _DataInputWidget extends ObservingStatefulWidget<DataInputWidget> {
  TextEditingController _textEditingController = TextEditingController();
  DataInputCubit _dataInputCubit;
  bool _shouldObscureText = true;

  @override
  void initState() {
    super.initState();
    _dataInputCubit = DataInputCubit();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle ?? TextStyle(fontSize: 24.0);
    return BlocBuilder<DataInputCubit, DataInputState>(
      cubit: _dataInputCubit,
      builder: (context, inputState) {
        switch (inputState.buildState) {
          case DataInputBuildState.ClearInputState:
            _textEditingController.text = '';
            break;
          case DataInputBuildState.InputReadyState:
            _shouldObscureText = (inputState as InputReadyState).textHiddenState;
            break;
          case DataInputBuildState.ObscureTextState:
            _shouldObscureText = (inputState as ObscureTextState).state;
            break;
          case DataInputBuildState.DataInputInitial:
            _dataInputCubit.initialState(dataInputType: widget.dataInputType);
            return Container();
        }
        return Focus(
            child: TextField(
              autocorrect: false,
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: widget.hint,
                suffixIcon: _dataInputCubit.gestureDetector(),
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
