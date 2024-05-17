
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elemoment/features/data/api/api_checker.dart';
import 'package:elemoment/features/data/repositories/auth_repo.dart';
import 'package:elemoment/features/presentation/blocs/auth/auth_event.dart';
import 'package:elemoment/features/presentation/blocs/auth/auth_state.dart';
import 'package:elemoment/features/presentation/components/utility/snackbar.dart';
import 'package:get/get.dart';

import '../../components/utility/delay.dart';
import '../status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  AuthRepo repo;

  AuthBloc({
    required this.repo
  }): super(AuthState.init()){
    on<LoginWithEmailAuthEvent>(loginWithEmail);
    on<SaveInfoUser>(saveAccessToken);
    on<GetCurrentUser>(getCurrentUser);
  }

  Future<void> loginWithEmail(
      LoginWithEmailAuthEvent event,
      Emitter<AuthState> emit
  ) async{
    if(state.status[AuthStatus.Login] == Status.loading) return;
    emit(state.copyWithStatus(authStatus: AuthStatus.Login, status: Status.loading));
    await Future.delayed(1000.milliseconds);

    var response = await repo.login(
        userName: event.email,
        password: event.password,
        initialDeviceName: "hello ban"
    );

    if(response.statusCode == 200){
      add(SaveInfoUser(token: response.body['access_token'], userId: response.body['user_id']));
      await saveHomeServer(response.body['home_server']);

      emit(state.copyWithStatus(authStatus: AuthStatus.Login, status: Status.success));
    }else{
      emit(state.copyWithStatus(authStatus: AuthStatus.Login, status: Status.failure));
    }
  }

  Future<void> saveAccessToken(
      SaveInfoUser event,
      Emitter<AuthState> emit
  ) async{
    repo.saveTokenUser(event.token);
    repo.saveUserId(event.userId);
  }

  Future<void> saveHomeServer(String url) async{
    await repo.saveHomeServer(url);
  }

  Future<void> getCurrentUser(
      GetCurrentUser event,
      Emitter<AuthState> emit
      ) async {
    String? userId = repo.getUserId();
    if(userId == null){
      showCustomSnackBar("không có userId");
    }else{
      print(userId);
      emit(state.copyWithUserId(userIds: userId ?? ""));
    }
  }
}