import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_package/src/password_manager.dart';

class PasswordWidget extends StatefulWidget {
  final Brightness brightness = Brightness.dark;
  final Color unfocusIconColor = Colors.blueGrey;

  @override
  _PasswordWidget createState() => _PasswordWidget();
}

class _PasswordWidget extends State<PasswordWidget> {
  PasswordManager _passwordManager = PasswordManager();
  TextEditingController _textEditingController;
  PasswordItem _passwordItem;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    debugPrint('InitState');
    Future.delayed(const Duration(), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streamBuilder = StreamBuilder<PasswordItem>(
        stream: _passwordManager.stream,
        builder: (context, snapshot) {
          _passwordItem = snapshot.data ?? PasswordItem();
          debugPrint('Stream: ${_passwordItem.toString()}');

          final container = Container(
            child: _textField(),
          );
          return container;
        });
    return Theme(
      child: streamBuilder,
      data: _themeData(context),
    );
  }

  ThemeData _themeData(BuildContext context) {
    return Theme.of(context).copyWith(
      brightness: widget.brightness,
      primaryColor: Colors.green,
      accentColor: Colors.red,
    );
  }

  Widget _textField() {
    return TextField(
      autocorrect: false,
      enableInteractiveSelection: _passwordItem.passwordSelection,
      enableSuggestions: false,
      obscureText: _passwordItem.obscureText,
      controller: _textEditingController,
      onChanged: (text) => _passwordManager.updateSelectable(content: text),
      decoration: InputDecoration(
        suffixIcon: _suffixIcon(),
      ),
    );
  }

  Color _iconColor() {
    if (_focusNode.hasFocus)
      return (widget.brightness == Brightness.light) ? _themeData(null).primaryColor : _themeData(null).accentColor;
    else
      return widget.unfocusIconColor;
  }

  Widget _suffixIcon() {
    return GestureDetector(
      child: Icon(Icons.remove_red_eye),
      onTapDown: (_) => _passwordManager.updateState(PasswordState.show),
      onTapUp: (_) => _passwordManager.updateState(PasswordState.hide),
      onTapCancel: () => _passwordManager.updateState(PasswordState.cancel),
      onPanEnd: (detail) => debugPrint('On Pan End'),
      onDoubleTap: () => debugPrint('Double Tap'),
      onLongPressStart: (detail) => _passwordManager.updateState(PasswordState.longPressDown),
      onLongPressEnd: (detail) => _passwordManager.updateState(PasswordState.longPressUp),
    );
  }
}
