part of 'data_input_cubit.dart';

enum DataInputBuildState {
  ClearInputState,
  DataInputInitial,
  InputReadyState,
  ObscureTextState,
}

@immutable
abstract class DataInputState extends Equatable {
  final DataInputBuildState buildState;
  const DataInputState(this.buildState);
  @override
  List<Object> get props => [buildState];
}
