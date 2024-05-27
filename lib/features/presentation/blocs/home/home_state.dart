
import 'package:equatable/equatable.dart';

import '../../../data/models/response/room.dart';

class HomeSate extends Equatable{
  final Map<String, Room> rooms;

  const HomeSate({
    required this.rooms
});

  HomeSate.init(): rooms = {};

  copyWithRooms({
    required Map<String, Room> myRooms,
  }){
    var newRooms = {...myRooms};
    return HomeSate(rooms: newRooms);
  }

  @override
  List<Object?> get props => [rooms];

}