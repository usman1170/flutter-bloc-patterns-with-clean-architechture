import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_mvvm/repository/auth_repository.dart';
import 'package:bloc_mvvm/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
  }
  void _login(LoginEvent event, emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    Map data = {"email": event.email, "password": event.password};
    await authRepository.login(data).then((value) {
      if (value.error!.isNotEmpty) {
        emit(state.copyWith(msg: value.error, authStatus: AuthStatus.failed));
      } else {
        emit(state.copyWith(msg: value.token, authStatus: AuthStatus.success));
      }
    }).onError(
      (error, stackTrace) {
        log("Error trace bloc : $error");
        emit(state.copyWith(
            msg: error.toString(), authStatus: AuthStatus.failed));
      },
    );
  }

  void _signUp(SignUpEvent event, emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    Map data = {"email": event.email, "password": event.password};
    await authRepository.signUp(data).then((value) {
      if (value.error!.isNotEmpty) {
        emit(state.copyWith(msg: value.error, authStatus: AuthStatus.failed));
      } else {
        emit(state.copyWith(msg: value.token, authStatus: AuthStatus.success));
      }
    }).onError(
      (error, stackTrace) {
        log("Error trace bloc : $error");
        emit(state.copyWith(
            msg: error.toString(), authStatus: AuthStatus.failed));
      },
    );
  }
}
