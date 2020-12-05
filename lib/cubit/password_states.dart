part of 'password_cubit.dart';

class PasswordInitial extends PasswordState {
  const PasswordInitial() : super(PasswordBuildState.PasswordInitial);
}

class ObscureTextState extends PasswordState {
  final bool state;
  const ObscureTextState(this.state) : super(PasswordBuildState.ObscureTextState);
  @override
  List<Object> get props => [state, buildState];
}
