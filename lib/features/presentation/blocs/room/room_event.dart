import 'package:elemoment/features/data/models/response/message.dart';
import 'package:elemoment/features/data/models/response/room.dart';

sealed class RoomEvent{}

class SyncRoomMessageEvent extends RoomEvent{
  String roomId;

  SyncRoomMessageEvent({
    required this.roomId,
});
}

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

class SendTextMessage extends RoomEvent{
  Message data;

  SendTextMessage({
    required this.data,
  });
}
