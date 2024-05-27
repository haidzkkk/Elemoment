
import 'package:elemoment/features/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/app_constants.dart';
import '../models/response/message.dart';
import '../models/response/room.dart';

class RoomRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RoomRepo({required this.apiClient, required this.sharedPreferences});

  Future<Map<String, Room>> getRooms({
    int? filter = 0,
    int? timeout = 30000,
    String? set_presence = 'online',
  }) async{
    var response = await apiClient.getData(AppConstants.GET_SYNC
        + "?filter=$filter"
            "&timeout=$timeout"
            "");
    if(response.statusCode == 200){
      sharedPreferences.setString(AppConstants.SINCE, response.body["next_batch"]);
      Map<String, Room> myRooms = {};
      for (var element in (response.body['rooms']['join'] as Map<dynamic, dynamic>).entries) {
        myRooms[element.key] = Room.fromJson(element.value);
      }
      return myRooms;
    }else{
      throw Exception("Không thể lấy data");
    }
  }

  Future<Map<String, Room>> syncData({
    int? filter = 0,
    int? timeout = 30000,
    String? setPresence = 'online',
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
      Map<String, Room> myRooms = {};
      for (var element in (response.body['rooms']['join'] as Map<dynamic, dynamic>).entries) {
        myRooms[element.key] = Room.fromJson(element.value);
      }
      return myRooms;
    }else{
      print("mesage sync: Không thể lấy data");
      throw Exception("Không thể lấy data");
    }
  }

}