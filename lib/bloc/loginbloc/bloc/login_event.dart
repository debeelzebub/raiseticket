part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
   const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
    final String employeeCode;
    final String password;
    final String mobileLogin;
    final String imeiNumber;
    final int validationOnly;
    final String sessionID;

  const LoginButtonPressed({
  required this.employeeCode,
  required this.password,
  required this.mobileLogin,
  required this.imeiNumber,
  required this.validationOnly,
  required this.sessionID,
  });
}