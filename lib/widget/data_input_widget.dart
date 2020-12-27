// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:data_input_package/widget/widget_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_package/theme_package.dart';

import '../cubit/data_input_cubit.dart';

class DataInputWidget extends StatefulWidget {
  final String startingText;
  final DataInputType dataInputType;
  final Function(String) callback;
  final Function(String) completion;
  final TextStyle textStyle;
  final String hint;
  final DataInputCubit dataInputCubit;
  const DataInputWidget({
    Key key,
    @required this.dataInputType,
    @required this.callback,
    @required this.completion,
    this.startingText,
    this.hint,
    this.textStyle,
    this.dataInputCubit,
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
    Log.M('initState CUBIT HASH: ${widget.dataInputCubit?.hashCode}');
    _dataInputCubit = widget.dataInputCubit ?? DataInputCubit();
  }

  @override
  void afterFirstLayoutComplete(BuildContext context) {
    if (widget.startingText != null) _textEditingController.text = widget.startingText;
  }

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
        debugPrint('..... textController ${_textEditingController.text}');
        return Focus(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                autocorrect: false,
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: _dataInputCubit.gestureDetector(),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                enableSuggestions: false,
                obscureText: _shouldObscureText,
                onChanged: (text) {
                  if (widget.callback is Function) widget.callback(text);
                },
                style: textStyle,
              ),
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
