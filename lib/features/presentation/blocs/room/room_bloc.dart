
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elemoment/features/data/repositories/message_repo.dart';
import 'package:elemoment/features/presentation/blocs/room/room_event.dart';
import 'package:elemoment/features/presentation/blocs/room/room_state.dart';

import '../../components/utility/snackbar.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState>{
  MessageRepo messageRepo;

  RoomBloc({
    required this.messageRepo
  }): super(RoomState.init()){
    on<GetMessageRoomEvent>(getMessage);
    on<ClearRoomEvent>((event, emit) => emit(RoomState.init()));
  }

  Future<void> getMessage(GetMessageRoomEvent event, Emitter<RoomState> emit) async {
    try{
      emit(state.copyWith(currentRoom: event.currentRoom));

      var response = await messageRepo.getRooms(roomId: event.roomId);
      emit(state.copyWithMessages(
          isAddAll: false,
          currentMessage: response[MessageRepoDataRes.data]
      ));
    }catch(error){
      print(error);
      showCustomSnackBar(error.toString());
    }
  }
}