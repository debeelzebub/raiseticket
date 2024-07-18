import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:raise_ticket/api/db.dart';
import 'package:raise_ticket/bloc/loginbloc/bloc/login_bloc.dart';
import 'package:raise_ticket/model/loginmodel.dart';
import 'package:raise_ticket/raiseticket.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLogin extends StatefulWidget {
  MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isVisible = true;
  bool isVisible1 = false;
  bool showpass = true;
  var pri = 1;
  final uname = TextEditingController();
  final pass = TextEditingController();
  final cname = TextEditingController();

  late SharedPreferences pref;
  late bool newy;
  bool newly = true;
  List<dynamic> info = [];
  var id;
  final _formKey = GlobalKey<FormState>();
  bool readonly = false;
  LocalAuthentication auth = LocalAuthentication();
  bool login=false;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      pref = prefs;
      check_user_already_login();
    });
  }

  Future<bool> _onWillPops() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void check_user_already_login() {
    if (pref.getBool('newy') == false) {
      setState(() {
        newly = false;

      });
      String username =pref.getString('uname')??"";
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RaiseTicketForm(usercode: username,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPops,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            // Handle loading state
          } else if (state is LoginSuccess) {
            // Handle successful login
            login=false;
            pref.setBool('newy',false);
            pref.setString('uname',uname.text);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Login Successfully")));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RaiseTicketForm(usercode: uname.text,)),
            );
          } else if (state is LoginFailure) {
            // Handle login failure
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Wrong Employee ID or password")));
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: newly == false
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 60),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 110,
                              child: Image.asset(
                                "assets/image/Tablet login-cuate (1).png",
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 3,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    Textfieldss(
                                      'Employee ID',
                                      'Enter Your Employee ID',
                                      const Icon(
                                        Icons.person,
                                        color: Colors.red,
                                      ),
                                      uname,
                                      false,
                                    ),
                                    const SizedBox(height: 5),
                                    Textfieldss(
                                      'Password',
                                      'Enter Your Password',
                                      const Icon(
                                        Icons.lock,
                                        color: Colors.red,
                                      ),
                                      pass,
                                      showpass,
                                      sicon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showpass = !showpass;
                                          });
                                        },
                                        icon: Icon(
                                          showpass
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.red,
                                        ),
                                      ),
                                      obchar: '*',
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                        decoration: BoxDecoration(
                                        color: Colors.red, // Background color
                                        borderRadius: BorderRadius.circular(30), // Rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60), // Button padding
                                        child: GestureDetector(
                                        onTap: () {
                                          if(uname.text!="" && pass.text !=""){
                                          login = true;
                                          context.read<LoginBloc>().add(
                                                LoginButtonPressed(
                                                  employeeCode: uname.text,
                                                  password: pass.text,
                                                  imeiNumber: "12345",
                                                  mobileLogin: "1",
                                                  sessionID: "123",
                                                  validationOnly: 0,
                                                ),
                                              );
                                              setState(() {
                                                
                                              });
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill the fields")));
                                          }
                                        },  
                                        child:login==false? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.login, color: Colors.white), // Login icon
                                            SizedBox(width: 8), // Spacer between icon and text
                                            Text(
                                              "Login",
                                              style: TextStyle(color: Colors.white),
                                            ), // Login text
                                          ],
                                        ):SpinKitThreeBounce(
                                              color: Colors.white,
                                              size: 15.0,
                                            )
                                        ),
                                        ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Textfieldss(
    String label,
    String htext,
    Widget icon,
    TextEditingController controllers,
    bool obtext, {
    Widget? sicon,
    String? obchar,
  }) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: TextFormField(
            controller: controllers,
            obscureText: obtext,
            decoration: InputDecoration(
              hintText: htext,
              hintStyle: TextStyle(fontSize: 14, color: Colors.red),
              contentPadding: EdgeInsets.symmetric(vertical: 23),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              prefixIcon: icon,
              suffixIcon: sicon,
              fillColor: Color.fromARGB(61, 244, 67, 54),
              filled: true,
            ),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return "Please fill the TextField";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  void showToast2() {
    setState(() {
      isVisible = false;
      isVisible1 = true;
    });
  }

  List<dynamic> mainmodel = [];
}
