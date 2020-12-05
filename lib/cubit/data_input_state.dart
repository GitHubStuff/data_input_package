// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

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
