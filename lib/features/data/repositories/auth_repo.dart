import 'package:elemoment/features/data/models/request/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../common/constants/app_constants.dart';
import '../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login({
        required String userName,
        required String password,
        required String initialDeviceName,
        String? deviceId,
  }) async {
    late Login login;
    if(userName.isEmail){
      login = Login.thirdPartyIdentifier(
          medium: ThreePidMedium.EMAIL,
          address: userName,
          password: password,
          initialDeviceDisplayName: initialDeviceName,
          deviceId: deviceId
      );
    }else{
    }
    return await apiClient.postData(AppConstants.LOGIN_URI, login, null);
  }

  Future<void> saveTokenUser(String token) async {
    String bearerToken = "Bearer " + token;
    await sharedPreferences.setString(AppConstants.TOKEN, bearerToken);
    apiClient.updateHeader(
      bearerToken,
      null,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      0,
    );
  }

  Future<void> saveUserId(String userId) async {
    await sharedPreferences.setString(AppConstants.USER_ID, userId);
  }

  String? getUserId(){
    return sharedPreferences.getString(AppConstants.USER_ID);
  }

  Future<void> saveHomeServer(String url) async {
    AppConstants.HOME_SERVER = url;
    await sharedPreferences.setString(AppConstants.R_HOMESERVER, url);
  }

  Future<void> clearUserToken() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
  }

  Future<void> clearHomeServer() async {
    await sharedPreferences.remove(AppConstants.R_HOMESERVER);
  }
}