import 'package:hive/hive.dart';

import '../../../data/repositories/message_offline_repo.dart';
import '../../../data/repositories/room_offline_repo.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() {
    return _instance;
  }

  HiveManager._internal();

  Future<void> init() async {
    if (!Hive.isBoxOpen(RoomOfflineRepo.roomIdBoxName)) {
      await Hive.openBox(RoomOfflineRepo.roomIdBoxName);
    }
    if (!Hive.isBoxOpen(RoomOfflineRepo.roomBoxName)) {
      await Hive.openBox(RoomOfflineRepo.roomBoxName);
    }
    if (!Hive.isBoxOpen(MessageOfflineRepo.messageIdBoxName)) {
      await Hive.openBox(MessageOfflineRepo.messageIdBoxName);
    }
    if (!Hive.isBoxOpen(MessageOfflineRepo.messageBoxName)) {
      await Hive.openBox(MessageOfflineRepo.messageBoxName);
    }
  }

  Box getBox(String boxName) {
    return Hive.box(boxName);
  }
}