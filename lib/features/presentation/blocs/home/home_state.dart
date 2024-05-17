
import 'package:equatable/equatable.dart';

import '../../../data/models/response/room.dart';

class HomeSate extends Equatable{
  final Map<String, Room> rooms;

  const HomeSate({
    required this.rooms
});

  HomeSate.init(): rooms = {};

  copyWithRooms({
    bool? isAddAll = true,
    required Map<String, Room> myRooms,
  }){
    var newRooms = {...rooms};
    if(isAddAll == true){
      newRooms.addAll(myRooms);
    }else{
      newRooms = {...myRooms};
    }

    return HomeSate(rooms: newRooms);
  }

  @override
  List<Object?> get props => [rooms];

}