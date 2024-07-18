import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:raise_ticket/login.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MyLogin()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
          color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white,
                                    child: Image.asset('assets/icons/Mororra.png',height:80,width: 60,
                                  fit: BoxFit.cover,),
                                  ),
                                    SpinKitThreeBounce(
                                color: Colors.white,
                                size: 25.0,
                              )
            ],
          ),
        ),
      );
  }
}