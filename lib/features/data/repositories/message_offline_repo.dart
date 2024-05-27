
import 'package:elemoment/features/data/models/response/message.dart';
import 'package:hive/hive.dart';

import '../../presentation/components/utility/hive_manager.dart';

class MessageOfflineRepo{
  static const String messageIdBoxName = 'messageEventIdBox';
  static const String messageBoxName = 'messageBox';


  bool get hasCachedMessage =>
      Hive.box(messageBoxName).isNotEmpty;


  Future<void> syncMessageEventIds({
    required String roomId,
    required List<String> eventIds,
  }) async {
    late final Box box = HiveManager().getBox(messageIdBoxName);

    return box.put(roomId, eventIds);
  }

  Future<void> saveMessageEventIds({
    required String roomId,
    required List<String> eventIds,
  }) async {
    late final Box box = HiveManager().getBox(messageIdBoxName);

    List<String> eventIds = await getMessageEventIds(roomId: roomId);
    eventIds.insertAll(0, eventIds);
    return box.put(roomId, eventIds);
  }

  Future<void> saveMessage({required Message message}) async {
    late final Box box = HiveManager().getBox(messageBoxName);

    return box.put(message.eventId, message.toJson());
  }

  Future<void> saveMessages({required List<Message> messages}) async {
    late final Box box = HiveManager().getBox(messageBoxName);

    for (var element in messages) {
      box.put(element.eventId, element.toJson());
    }
  }

  Future<List<String>> getMessageEventIds({required String roomId}) async {
    try {
      late final Box box = HiveManager().getBox(messageIdBoxName);
      final List<String>? ids = box.get(roomId);

      return ids ?? [];
    } catch (_) {
      print('------------${_.toString()}');
      await Hive.deleteBoxFromDisk(messageIdBoxName);
      return [];
    }
  }

  Future<Message?> getMessage({required String eventId}) async {
    late final Box box = HiveManager().getBox(messageBoxName);

    final Map<dynamic, dynamic>? json = box.get(eventId);
    if (json == null) {
      return null;
    }
    final Message message = Message.fromJson(json.cast<String, dynamic>());
    return message;
  }

  Future<List<Message>> getMessages({required List<String> eventIds}) async{
    late final Box box = HiveManager().getBox(messageBoxName);

    List<Message> myMessage = [];
    for (final String eventId in eventIds) {
      final Map<dynamic, dynamic>? json = box.get(eventId);
      if (json == null) continue;
      final Message message = Message.fromJson(json.cast<String, dynamic>());
      myMessage.add(message);
    }
    return myMessage;
  }
}
