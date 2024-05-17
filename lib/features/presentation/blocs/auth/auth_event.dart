
sealed class AuthEvent{}

class LoginWithEmailAuthEvent extends AuthEvent{
  String email;
  String password;

  LoginWithEmailAuthEvent({
    required this.email,
    required this.password
  });
}

class LoginWithNumberPhoneAuthEvent extends AuthEvent{
  String phoneNumber;

  LoginWithNumberPhoneAuthEvent({
    required this.phoneNumber,
  });
}

class SaveInfoUser extends AuthEvent{
  String token;
  String userId;

  SaveInfoUser({
    required this.token,
    required this.userId,
  });
}

class GetCurrentUser extends AuthEvent{
}

