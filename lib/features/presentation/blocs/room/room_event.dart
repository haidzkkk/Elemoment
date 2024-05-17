import 'package:elemoment/features/data/models/response/room.dart';

sealed class RoomEvent{}

class GetMessageRoomEvent extends RoomEvent{
  String roomId;
  Room currentRoom;

  GetMessageRoomEvent({
    required this.roomId,
    required this.currentRoom,
});
}

class ClearRoomEvent extends RoomEvent{
  ClearRoomEvent();
}