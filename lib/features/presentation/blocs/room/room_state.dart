
import 'package:equatable/equatable.dart';

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

  copyWithMessages({
    bool? isAddAll = true,
    required List<Message> currentMessage
  }){
    var newMessages = [...this.currentMessage];
    if(isAddAll == true){
      newMessages.addAll(currentMessage);
    }else{
      newMessages = [...currentMessage];
    }

    return RoomState(
        currentRoom: currentRoom,
        currentMessage: newMessages,
    );
  }

  @override
  List<Object?> get props => [currentRoom, currentMessage];

}