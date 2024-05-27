import '../../../common/constants/app_constants.dart';

extension ExtentionString on String {
  bool isEmail() => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}

String getUrlMedia(String? url){
  if(url == null) return "";
  String baseUrl = AppConstants.BASE_URL + AppConstants.MEDIA_DATA;
  List<String> urls = url.split("/");

  if(urls.isEmpty){
    return "";
  }else if(urls.length == 1){
    return url;
  }else{
    String mediaUrl = "$baseUrl/${urls[urls.length - 2]}/${urls.last}";
    return mediaUrl;
  }
}