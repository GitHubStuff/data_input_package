part of 'password_cubit.dart';

enum PasswordBuildState {
  PasswordInitial,
}

@immutable
abstract class PasswordState extends Equatable {
  final PasswordBuildState buildState;
  const PasswordState(this.buildState);
  @override
  List<Object> get props => [buildState];
}
