import 'package:elemoment/features/common/constants/app_constants.dart';
import 'package:elemoment/features/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({required this.apiClient, required this.sharedPreferences});

  bool getCurrentUser(){
    // return apiClient.getData(AppConstants.GET_CURRENT_USER);
    return sharedPreferences.getString(AppConstants.TOKEN) != null;
  }
}