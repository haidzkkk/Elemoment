import 'package:equatable/equatable.dart';

import '../status.dart';

enum AuthStatus{
  Login,
  Signup
}

class AuthState extends Equatable{
  final String userId;
  final Map<AuthStatus, Status> status;

  const AuthState({
      required this.userId,
      required this.status,
  });

  AuthState.init(

  ) : userId = '',
  status = {
    AuthStatus.Login: Status.idle,
    AuthStatus.Signup: Status.idle,
  };

  copyWith({
    String? userId,
    Map<AuthStatus, Status>? status
  }){
    return AuthState(
        userId: userId ?? this.userId,
        status: status ?? this.status
    );
  }

  copyWithUserId({
    required String userIds,
  }){
    return AuthState(
        userId: userIds,
        status: status
    );
  }

  copyWithStatus({
    required AuthStatus authStatus,
    required Status status,
  }){
    var newAuthStatus = Map<AuthStatus, Status>.from(this.status);
    newAuthStatus[authStatus] = status;
    return AuthState(
        userId: userId,
        status: newAuthStatus
    );
  }

  @override
  List<Object?> get props => [
    status
  ];

}