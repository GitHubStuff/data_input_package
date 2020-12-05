import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_package/cubit/password_cubit.dart';

import 'observing_stateful_widget.dart';

class PasswordWidget extends StatefulWidget {
  final Function(String) callback;
  final Function(String) completion;
  const PasswordWidget({Key key, @required this.callback, @required this.completion}) : super(key: key);
  @override
  _PasswordWidget createState() => _PasswordWidget();
}

class _PasswordWidget extends ObservingStatefulWidget<PasswordWidget> {
  TextEditingController _textEditingController = TextEditingController();
  PasswordCubit _passwordCubit;

  @override
  void initState() {
    super.initState();
    _passwordCubit = PasswordCubit();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordCubit, PasswordState>(
      cubit: _passwordCubit,
      builder: (context, passwordState) {
        debugPrint('STATE: $passwordState');
        return Focus(
            child: TextField(
              enableSuggestions: false,
              controller: _textEditingController,
              onChanged: (text) {
                if (widget.callback is Function) widget.callback(text);
              },
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
