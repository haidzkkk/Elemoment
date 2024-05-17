import 'dart:async';
import 'package:elemoment/features/data/repositories/splash_repo.dart';
import 'package:elemoment/features/presentation/blocs/splash/splash_event.dart';
import 'package:elemoment/features/presentation/components/utility/delay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'splash_state.dart';
import 'package:get/get.dart';

class SplashBloc extends Bloc<SplashEvent,SplashState>{
  final SplashRepo repo = GetIt.instance.get<SplashRepo>();
  SplashBloc() : super(Loading()) {
    on<LoadingEvent>(getCurrentUser);
  }
  Future<void> getCurrentUser(SplashEvent event, Emitter<SplashState> emit) async {
    bool response = repo.getCurrentUser();
    delay(1000);
    if(response){
      emit(Success());
    }
    else{
      emit(Failure());
    }
  }
}