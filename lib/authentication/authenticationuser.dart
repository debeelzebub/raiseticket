// import 'dart:convert';
// import 'package:raise_ticket/model/loginmodel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static const String _keyApiResponse = 'keyApiResponse';

//   Future<void> saveApiResponse(LoginResponse apiResponse) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String jsonString = jsonEncode(apiResponse);
//     await prefs.setString(_keyApiResponse, jsonString);
//   }

//   Future<LoginResponse?> getApiResponse() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? jsonString = prefs.getString(_keyApiResponse);
//     if (jsonString != null) {
//       Map<String, dynamic> jsonMap = jsonDecode(jsonString);
//       return ApiResponse.fromJson(jsonMap);
//     }
//     return null;
//   }

//   Future<void> clearApiResponse() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyApiResponse);
//   }
// }
