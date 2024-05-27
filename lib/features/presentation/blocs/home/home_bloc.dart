import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:elemoment/features/data/repositories/message_offline_repo.dart';
import 'package:elemoment/features/data/repositories/room_offline_repo.dart';
import 'package:elemoment/features/presentation/blocs/home/home_state.dart';
import 'package:elemoment/features/presentation/components/utility/snackbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../data/models/response/room.dart';
import '../../../data/repositories/room_repo.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeSate>{
  RoomRepo roomRepo;
  RoomOfflineRepo roomOfflineRepo;
  MessageOfflineRepo messageOfflineRepo;

  String userId = "";
  bool isSync = false;

  HomeBloc({
    required this.roomRepo,
    required this.roomOfflineRepo,
    required this.messageOfflineRepo,
  }): super(HomeSate.init()){
   on<GetRoomHomeEvent>(getRoom);
   on<SyncDataEvent>(syncData);
   on<StopSyncDataEvent>(clearSync);

   print("roomOfflineRepo.hasCachedRoom: ${roomOfflineRepo.hasCachedRoom}");
  }

  Future<void> getRoom(GetRoomHomeEvent event, Emitter<HomeSate> emit) async {
    await roomRepo.getRooms().then((response) async{
      // await roomOfflineRepo.syncRoomIds(userId: userId, roomIds: response.keys.toList());
      // await roomOfflineRepo.saveRooms(rooms: response);
      emit(state.copyWithRooms(myRooms: response));
      add(SyncDataEvent());
    }).onError((error, stackTrace) {
      showCustomSnackBar(error.toString());
    });
  }

  Future<void> syncData(SyncDataEvent event, Emitter<HomeSate> emit) async {

    isSync = true;
    while(isSync){
      try{
        var response = await roomRepo.syncData();

        // var roomIds = await roomOfflineRepo.getRoomIds(userId: userId);
        // var rooms = await roomOfflineRepo.getRooms(roomIds: roomIds);
        var data = {...state.rooms};

        for(var element in response.entries){
          if(data[element.key] != null){
              data[element.key] = data[element.key]!..timeline?.events?.addAll(element.value.timeline?.events ?? []);
          }else{
            data[element.key] = element.value;
          }

          await messageOfflineRepo.saveMessageEventIds(roomId: element.key, eventIds: element.value.timeline?.events?.map((e) => e.eventId!).toList() ?? []);
          await messageOfflineRepo.saveMessages(messages: element.value.timeline?.events ?? []);
        }

        await roomOfflineRepo.saveRoomIds(userId: userId, roomIds: response.keys.toList());
        await roomOfflineRepo.saveRooms(rooms: data);
        emit(state.copyWithRooms(myRooms: data));
      }catch(e){
        print(e);
      }
    }
  }

  Future<void> clearSync(StopSyncDataEvent event, Emitter<HomeSate> emit) async {
    isSync = false;
    emit(HomeSate.init());
  }
}