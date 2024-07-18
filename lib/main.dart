import 'package:flutter/material.dart';
import 'package:raise_ticket/bloc/loginbloc/bloc/login_bloc.dart';
import 'package:raise_ticket/bloc/raisedticketbloc/bloc/raise_bloc_bloc.dart';
import 'package:raise_ticket/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(MyApp(),
  );
}



class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(create: (context)=>RaiseBlocBloc())
      ],
      child: MaterialApp(
      title: 'Raise Ticket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.red,
        primaryIconTheme: IconThemeData(color: Color.fromARGB(255, 201, 36, 25)),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 201, 36, 25)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 201, 36, 25)),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromARGB(255, 201, 36, 25)
        )
      ),
      home: MyWidget()
        
      ),
    );
  }
}
