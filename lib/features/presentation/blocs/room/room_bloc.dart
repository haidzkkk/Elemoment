
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elemoment/features/data/models/response/message.dart';
import 'package:elemoment/features/data/repositories/message_repo.dart';
import 'package:elemoment/features/presentation/blocs/room/room_event.dart';
import 'package:elemoment/features/presentation/blocs/room/room_state.dart';

import '../../../data/repositories/message_offline_repo.dart';
import '../../components/utility/snackbar.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState>{
  MessageRepo messageRepo;
  MessageOfflineRepo messageOfflineRepo;
  bool isSync = false;
  RoomBloc({
    required this.messageRepo,
    required this.messageOfflineRepo,
  }): super(RoomState.init()){
    on<SyncRoomMessageEvent>(startSync);
    on<GetMessageRoomEvent>(getAllMessage);
    on<ClearRoomEvent>(clearRoom);
    on<SendTextMessage>(sendTextMessage);
  }

  Future<void> startSync(SyncRoomMessageEvent event, Emitter<RoomState> emit) async {
    // isSync = true;
    // while(isSync){
    //   try{
    //     var response = await messageRepo.syncMessageData(roomId: event.roomId);
    //     for (var element in response) {
    //       emit(state.copyWithAddMessages(currentMessage: element));
    //     }
    //   }catch(e){}
    // }
  }

  Future<void> getAllMessage(GetMessageRoomEvent event, Emitter<RoomState> emit) async {
    try{
      emit(state.copyWith(currentRoom: event.currentRoom));

      var response = await messageRepo.getRooms(roomId: event.roomId);
      emit(state.copyWithListMessages(currentMessage: response[MessageRepoDataRes.data]));
      // add(SyncRoomMessageEvent(roomId: event.roomId));
    }catch(error){
      print(error);
      showCustomSnackBar(error.toString());
    }
  }

  Future<void> sendTextMessage(SendTextMessage event, Emitter<RoomState> emit) async{
    emit(state.copyWithAddMessages(currentMessage: event.data));
    if(event.data.roomId != null) {
      try{
        await messageRepo.sendMessage(roomId: event.data.roomId!, msg: event.data.content?.body ?? "null");
      }catch(e){
        event.data.statusLocal = MessageStatusLocal.sentFail;
        emit(state.copyWithAddMessages(currentMessage: event.data));
      }
    }else{
      event.data.statusLocal = MessageStatusLocal.sentFail;
      emit(state.copyWithAddMessages(currentMessage: event.data));
    }
  }

  Future<void> clearRoom(ClearRoomEvent event, Emitter<RoomState> emit) async {
    isSync = false;
    emit(RoomState.init());
  }
}