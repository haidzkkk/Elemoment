import '../../data/models/request/language_model.dart';
import '../../presentation/components/utility/images.dart';

class AppConstants{
  /// api
  static const String BASE_URL = 'https://matrix-client.matrix.org';
  static const String BASE_URL_SERVER_BASE = 'https://matrix.org';
  static String HOME_SERVER = 'matrix.org';

  static const String GET_CURRENT_USER = '/';
  static const String LOGIN_URI = '/_matrix/client/r0/login';
  static const String GET_ROOM = '/_matrix/client/v3/sync';
  static const String GET_MESSAGE = '/_matrix/client/v3/rooms/';
  static const String MEDIA_DATA = '/_matrix/media/v3/download';

  /// sharepreferent key
  static const String TOKEN = 'token';
  static const String USER_ID = 'abcokhihi-user_id';
  static const String R_HOMESERVER = 'abcokhihi-homeserver';
  static const String LANGUAGE_CODE = 'language_code';
  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';
  /// language
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.logo,
        languageName: 'Việt Nam',
        countryCode: 'VN',
        languageCode: 'vi'),
    LanguageModel(
        imageUrl: Images.logo,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}