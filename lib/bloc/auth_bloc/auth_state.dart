part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final String msg;
  final AuthStatus authStatus;

  const AuthState({
    this.email = "",
    this.password = "",
    this.msg = "",
    this.authStatus = AuthStatus.initial,
  });

  AuthState copyWith({
    String? email,
    String? password,
    String? msg,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      msg: msg ?? this.msg,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object?> get props => [email, password, msg, authStatus];
}
