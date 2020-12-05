part of 'data_input_cubit.dart';

class DataInputInitial extends DataInputState {
  const DataInputInitial() : super(DataInputBuildState.DataInputInitial);
}

class ObscureTextState extends DataInputState {
  final bool state;
  const ObscureTextState(this.state) : super(DataInputBuildState.ObscureTextState);
  @override
  List<Object> get props => [state, buildState];
}
