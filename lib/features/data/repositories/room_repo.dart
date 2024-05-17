
import 'package:elemoment/features/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/app_constants.dart';
import '../models/response/room.dart';

class RoomRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RoomRepo({required this.apiClient, required this.sharedPreferences});

  Future<Map<String, Room>> getRooms({
    int? filter = 0,
    int? timeout = 30000,
    String? set_presence = 'online',
    String? since = 's4930088281_757284974_306802_2814873273_3052938286_193664285_1324247601_10646135630_0_283106',
  }) async{
    var response = await apiClient.getData(AppConstants.GET_ROOM
        + "?filter=$filter"
            "&timeout=$timeout"
            "");

    if(response.statusCode == 200){
      Map<String, Room> myRooms = {};
      for (var element in (response.body['rooms']['join'] as Map<dynamic, dynamic>).entries) {
        myRooms[element.key] = Room.fromJson(element.value);
      }
      return myRooms;
    }else{
      throw Exception("Không thể lấy data");
    }
  }
}