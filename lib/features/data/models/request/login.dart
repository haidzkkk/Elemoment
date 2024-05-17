
class LoginFlowTypes {
  static const String PASSWORD = "m.login.password";
  static const String OAUTH2 = "m.login.oauth2";
  static const String EMAIL_CODE = "m.login.email.code";
  static const String EMAIL_URL = "m.login.email.url";
  static const String EMAIL_IDENTITY = "m.login.email.identity";
  static const String MSISDN = "m.login.msisdn";
  static const String RECAPTCHA = "m.login.recaptcha";
  static const String DUMMY = "m.login.dummy";
  static const String TERMS = "m.login.terms";
  static const String TOKEN = "m.login.token";
  static const String SSO = "m.login.sso";
}

class ThreePidMedium {
  static const EMAIL = "email";
  static const MSISDN = "msisdn";
}

class Login {
  static const String IDENTIFIER_KEY_TYPE = "type";

  static const String IDENTIFIER_KEY_TYPE_USER = "m.id.user";
  static const String IDENTIFIER_KEY_USER = "user";

  static const String IDENTIFIER_KEY_TYPE_THIRD_PARTY = "m.id.thirdparty";
  static const String IDENTIFIER_KEY_MEDIUM = "medium";
  static const String IDENTIFIER_KEY_ADDRESS = "address";

  static const String IDENTIFIER_KEY_TYPE_PHONE = "m.id.phone";
  static const String IDENTIFIER_KEY_COUNTRY = "country";
  static const String IDENTIFIER_KEY_PHONE = "phone";


  Map<String, dynamic>? identifier;
  String? password;
  String? type;
  String? initialDeviceDisplayName;
  String? deviceId;

  Login(
      {this.identifier,
        this.password,
        this.type,
        this.initialDeviceDisplayName,
        this.deviceId});

  Login.userIdentifier({
    required String user,
    this.password,
    this.initialDeviceDisplayName,
    this.deviceId,
  }){
    identifier = {
      IDENTIFIER_KEY_TYPE: IDENTIFIER_KEY_TYPE_USER,
      IDENTIFIER_KEY_USER: user
    };
    type = LoginFlowTypes.PASSWORD;
  }

  Login.thirdPartyIdentifier({
    required String medium,
    required String address,
    required this.password,
    required this.initialDeviceDisplayName,
    required this.deviceId,
  }){
    identifier = {
      IDENTIFIER_KEY_TYPE: IDENTIFIER_KEY_TYPE_THIRD_PARTY,
      IDENTIFIER_KEY_MEDIUM: medium,
      IDENTIFIER_KEY_ADDRESS: address,
    };
    type = LoginFlowTypes.PASSWORD;
  }

  Login.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    password = json['password'];
    type = json['type'];
    initialDeviceDisplayName = json['initial_device_display_name'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['password'] = this.password;
    data['type'] = this.type;
    data['initial_device_display_name'] = this.initialDeviceDisplayName;
    data['device_id'] = this.deviceId;

    return data;
  }
}
