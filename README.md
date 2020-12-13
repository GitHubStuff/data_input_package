# data_input_package

A Flutter package that has widgets for TextInput and PasswordInput

## Getting Started

```dart
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
  })
```

- dataInputType is either **DataInputType.PasswordInput** or **DataInputType.TextInput** and manages widget behavior
- callback is a function that will receive the input as it occurs
- completion is a function called when the input field loses focus, an indicator that input is complete
- textStyle is TextStyle that is applied to the TextField
- hint is an optional string that provides a hint in the TextField

## Features

PASSWORD - Text is obscured unless the user taps/(long presses) the ***eye*** icon that will briefly display entry text. A double tap will toggle the obscuring feature.

TEXT - The (X) icon will erase the current content of the field

## Conclusion

Be kind to each other
