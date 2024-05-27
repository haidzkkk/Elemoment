import 'package:elemoment/features/data/models/response/room.dart';
import 'package:elemoment/features/presentation/components/utility/hive_manager.dart';
import 'package:hive/hive.dart';

class RoomOfflineRepo {
  static const String roomIdBoxName = 'roomIdBox';
  static const String roomBoxName = 'roomBox';

  bool get hasCachedRoom => Hive.box(roomBoxName).isNotEmpty;

  Future<void> syncRoomIds({
    required String userId,
    required List<String> roomIds,
  }) async {
    late final Box box = HiveManager().getBox(roomIdBoxName);

    return box.put(userId, roomIds);
  }

  Future<void> saveRoomIds({
    required String userId,
    required List<String> roomIds,
  }) async {
    late final Box box = HiveManager().getBox(roomIdBoxName);

    List<String> myRoomIds = []; // getRoomIds();
    myRoomIds.insertAll(0, roomIds);

    return box.put(userId, myRoomIds.toSet().toList());
  }

  Future<void> saveRooms({required Map<String, Room> rooms}) async {
    late final Box box = HiveManager().getBox(roomBoxName);

    for (var element in rooms.entries) {
      box.put(element.key, element.value.toJson());
    }
  }

  Future<List<String>> getRoomIds({required String userId}) async {
    try {
      late final Box box = HiveManager().getBox(roomIdBoxName);
      final List<String>? ids = box.get(userId);

      return ids ?? [];
    } catch (_) {
      print('------------${_.toString()}');
      await Hive.deleteBoxFromDisk(roomIdBoxName);
      return [];
    }
  }

  Future<Map<String, Room>> getRooms({required List<String> roomIds}) async{
    late final Box box = HiveManager().getBox(roomBoxName);

    Map<String, Room> myRooms = {};
    for (final String roomId in roomIds) {
      final Map<dynamic, dynamic>? json = box.get(roomId);

      if (json == null) continue;
      final Room room = Room.fromJson(json.cast<String, dynamic>());
      myRooms[roomId] = room;
    }
    return myRooms;
  }
}