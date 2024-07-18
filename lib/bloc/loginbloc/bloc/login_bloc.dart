import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_ticket/api/api.dart';
import 'package:raise_ticket/api/request.dart';
import 'package:equatable/equatable.dart';
import 'package:raise_ticket/model/loginmodel.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiService apiService = ApiService();

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield* loginblocdetails(employeeCode: event.employeeCode, password:event.password, mobileLogin: event.mobileLogin, imeiNumber: event.imeiNumber, validationOnly: event.validationOnly, sessionID: event.sessionID);
    }

  }
  Stream<LoginState> loginblocdetails({ 
  required String employeeCode,
  required String password,
  required String mobileLogin,
  required String imeiNumber,
  required int validationOnly,
  required String sessionID,  
    }
  ) async* {
      yield LoginLoading();

        final response = await apiService.validateLogin(
          LoginRequest(
            employeeCode: employeeCode,
            password: password,
            mobileLogin: mobileLogin,
            imeiNumber: imeiNumber,
            validationOnly:validationOnly,
            sessionID: sessionID,
          ));
      if(response =="Success"){
        yield LoginSuccess(response);
      } else {
        yield LoginFailure(response);
      }
    }
 
  }

