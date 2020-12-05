// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

part of 'data_input_cubit.dart';

class ClearInputState extends DataInputState {
  const ClearInputState() : super(DataInputBuildState.ClearInputState);
}

class DataInputInitial extends DataInputState {
  const DataInputInitial() : super(DataInputBuildState.DataInputInitial);
}

class InputReadyState extends DataInputState {
  final bool textHiddenState;
  const InputReadyState(this.textHiddenState) : super(DataInputBuildState.InputReadyState);
}

class ObscureTextState extends DataInputState {
  final bool state;
  const ObscureTextState(this.state) : super(DataInputBuildState.ObscureTextState);
  @override
  List<Object> get props => [state, buildState];
}
