
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../../data/models/response/message.dart';
import '../../../data/models/response/room.dart';

class RoomState extends Equatable{
  final Room? currentRoom;
  final List<Message> currentMessage;

  const RoomState({
    this.currentRoom,
    required this.currentMessage,
  });

  RoomState.init(): currentRoom = null,
        currentMessage = [];

  copyWith({
    Room? currentRoom,
    List<Message>? currentMessage
  }){
    return RoomState(
        currentRoom: currentRoom ?? this.currentRoom,
        currentMessage: currentMessage ?? this.currentMessage,
    );
  }

  copyWithListMessages({
    bool? isAdd = true,
    required List<Message> currentMessage
  }){
    List<Message> newMessages = [...currentMessage];
    return RoomState(
        currentRoom: currentRoom,
        currentMessage: newMessages,
    );
  }

  copyWithAddMessages({
    required Message currentMessage
  }){
    List<Message> newMessages = [...this.currentMessage];

    int indexMsgFind = newMessages.indexWhere(
            (element) => (element.statusLocal == MessageStatusLocal.sending
                || element.statusLocal == MessageStatusLocal.sentFail)
                && element.content?.body == currentMessage.content?.body
    );

    if(indexMsgFind != -1) {
      newMessages[indexMsgFind] = currentMessage;
    }else{
      newMessages.insert(0, currentMessage);
    }
    return RoomState(
        currentRoom: currentRoom,
        currentMessage: newMessages,
    );
  }

  @override
  List<Object?> get props => [currentRoom, currentMessage];

}