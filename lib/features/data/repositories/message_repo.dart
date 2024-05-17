
import 'package:elemoment/features/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/app_constants.dart';
import '../models/response/message.dart';
import '../models/response/room.dart';

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
    var response = await apiClient.getData(AppConstants.GET_MESSAGE
            + "$roomId/messages"
            "?limit=$limit"
            "&dir=$dir"
            // "&from=$from"
            // "&filter=$filter"
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
}