import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:raise_ticket/api/db.dart';
import 'package:raise_ticket/api/request.dart';
import 'package:raise_ticket/api/responds.dart';
import 'package:raise_ticket/authentication/authenticationuser.dart';
import 'package:raise_ticket/model/loginmodel.dart';
import 'package:raise_ticket/model/raisefileupload.dart';
import 'package:raise_ticket/model/raiseticketmodel.dart';
import 'package:raise_ticket/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiService {
  Dio client = Dio();
  // final SharedPreferencesService _prefsService = SharedPreferencesService();

  raiseticketurl raisedata = raiseticketurl();
  // Future<LoginResponse> validateLogin(LoginRequest request) async {
  //   final response = await http.post(
  //     Uri.parse(raisedata.validateLogin),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(request.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     return LoginResponse.fromJson(jsonDecode(response.body));
  //     print(object)
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }

    Future<String> validateLogin(LoginRequest request) async {
        ResponseData? userlist;
   
    final response = await client.post(
      raisedata.validateLogin,
      data: request,
      options: Options( 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("create a grp ${response.data}");
    if(response.statusCode==200){
      
      userlist = ResponseData.fromJson(response.data);
     await SQlHelper.adddata(empname: userlist.loginDetails[0].employeeName??"",empcode:"${userlist.loginDetails[0].employeeCode}" ,designation: userlist.loginDetails[0].department??"",photo:"", bid: userlist.loginDetails[0].idBranch,cid: userlist.loginDetails[0].idCompany, bname: '${userlist.loginDetails[0].branchName}',  );
      // pref.setInt("${userlist.loginDetails[0].employeeCode}", id);
      // await _saveToSharedPreferences(userlist);
      if(userlist.loginDetails[0].statusMsg=="Success"){
        return "Success";
      }else{
      return "failed";
    }  
    }
    else{
      return "failed";
    }
  }

  Future<DataModel> getmaster(MasterRequest request) async {
   DataModel? masterlist;
   
    final response = await client.post(
      raisedata.getMaster,
      data: request,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    print("respondsssss ${response.data}");
   if (response.statusCode == 200) {
    // jsonResponse = json.decode(response.body); 
      masterlist = DataModel.fromJson(response.data);
      print("${masterlist.companyMaster}");
     
    } else {
      throw Exception('Failed to load data');
    }
    
    // (response.data as List).forEach((element) {
    //   masterlist.add(DataModel.fromJson(element));
    // });
    return masterlist;
  //   DoubleResponse(
  //       response.data['status'] == 'success', response.data['chatid']);
  }
//   Future<void> _saveToSharedPreferences(ResponseData userlist) async {
//   final prefs = await SharedPreferences.getInstance();
//   final userJson = jsonEncode(userlist.toJson());
//   await prefs.setString('user_data', userJson);
// }
// Future<ResponseData?> getUserData() async {
//   final prefs = await SharedPreferences.getInstance();
//   final userJson = prefs.getString('user_data');
//   if (userJson != null) {
//     final Map<String, dynamic> userMap = jsonDecode(userJson);
//     return ResponseData.fromJson(userMap);
//   }
//   return null;
// }
}
