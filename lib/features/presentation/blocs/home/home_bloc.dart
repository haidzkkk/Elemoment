import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:elemoment/features/presentation/blocs/home/home_state.dart';
import 'package:elemoment/features/presentation/components/utility/snackbar.dart';
import '../../../data/repositories/room_repo.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeSate>{
  RoomRepo roomRepo;

  HomeBloc({required this.roomRepo}): super(HomeSate.init()){
   on<GetRoomHomeEvent>(getRoom);
  }

  Future<void> getRoom(GetRoomHomeEvent event, Emitter<HomeSate> emit) async {
    await roomRepo.getRooms().then((response) {
      emit(state.copyWithRooms(myRooms: response));
    }).onError((error, stackTrace) {
      showCustomSnackBar(error.toString());
    });
  }
}