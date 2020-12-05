part of 'data_input_cubit.dart';

enum DataInputBuildState {
  ObscureTextState,
  DataInputInitial,
}

@immutable
abstract class DataInputState extends Equatable {
  final DataInputBuildState buildState;
  const DataInputState(this.buildState);
  @override
  List<Object> get props => [buildState];
}
