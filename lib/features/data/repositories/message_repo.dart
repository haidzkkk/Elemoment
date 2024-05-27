
import 'dart:math';

import 'package:elemoment/features/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constants/app_constants.dart';
import '../models/response/message.dart';

enum MessageRepoDataRes{
  start,
  end,
  data,
  error
}

class MessageRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MessageRepo({required this.apiClient, required this.sharedPreferences});

  Future<Map<MessageRepoDataRes, dynamic>> getRooms({
    required String roomId,
    int? limit = 50,
    String? dir = 'b',
    String? from = '',
    String? filter = '',
  }) async{
    var response = await apiClient.getData(AppConstants.ROOM
            + "/$roomId/messages"
            "?limit=$limit"
            "&dir=$dir"
            "");

    if(response.statusCode == 200){
      List<Message> myMessages = List.from(response.body['chunk'].map(
              (element) => Message.fromJson(element)).toList());
      return {
        MessageRepoDataRes.data: myMessages,
        MessageRepoDataRes.start: response.body['start'],
        MessageRepoDataRes.end: response.body['end'],
      };
    }else{
      throw Exception("Không thể lấy data");
    }
  }

  Future<List<Message>> syncMessageData({
    int? filter = 0,
    int? timeout = 30000,
    String? setPresence = 'online',
    required String roomId,
  }) async{
    String? since = sharedPreferences.getString(AppConstants.SINCE);

    var response = await apiClient.getData(AppConstants.GET_SYNC
        + "?filter=$filter"
            "&timeout=$timeout"
            "&set_presence=$setPresence"
            "&since=$since"
            "");
    if(response.body["next_batch"] != null) {
      sharedPreferences.setString(AppConstants.SINCE, response.body["next_batch"]);
    }
    if(response.statusCode == 200){
      List<Message> myMessages = List.from(response.body['rooms']['join'][roomId]['timeline']['events']
          .map((element) => Message.fromJson(element)).toList());

      print("mesage sync: ${myMessages.toString()}");
      return myMessages;
    }else{
      print("mesage sync: Không thể lấy data");
      throw Exception("Không thể lấy data");
    }
  }

  Future<String?> sendMessage(
  {
    required String roomId,
    required String msg,
    String? mentions,
    String? msgSend = "m.room.message",
    String? msgtype = "m.text"
}) async{
    var body = {
        "body": msg,
        // "m.mentions": mentions,
        "msgtype": msgtype,
    };
    String txnId = 'm${DateTime.now().millisecondsSinceEpoch}.${Random().nextInt(1000)}';
    var response = await apiClient.putData(
        "${AppConstants.ROOM}/$roomId${AppConstants.SEND_MESSAGE}/$msgSend/$txnId",
        body,
        headers: null
    );

    return response.body["event_id"];
  }
}