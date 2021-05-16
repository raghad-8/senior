import 'package:app1/Screens/Login.dart';
import 'package:app1/Screens/AddCompany.dart';
import 'package:app1/Screens/News.dart';
import 'package:app1/Screens/RecordMySituation.dart';
import 'package:app1/Screens/Services.dart';
import 'package:app1/Screens/Statistics.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Screens/News.dart';
import './Screens/Register.dart';
import 'Components/graphs.dart';
import './Screens/Services.dart';
import './Screens/users.dart';
import './Screens/Details.dart';
import './Screens/testgraph.dart';
import './Screens/ChatRoom.dart';
import 'package:firebase_core/firebase_core.dart';

/*import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Covid-19',
            home: Home(),
            routes: {
              'news': (context) {
                return News();
              },
              'recordsit': (context) {
                return RecordCovid();
              },
              'companyadd': (context) {
                return CompanyAdd();
              },
              'register': (context) {
                return Register();
              },
              'services': (context) {
                return Services();
              },
              'login': (context) {
                return SignIn(null);
              },
              'homepage': (context) {
                return Home();
              },
              "users": (context) {
                return Users();
              },
              "usersdetails": (context) {
                return UsersDetails();
              },
              "statistics": (context) {
                return Statistics();
              },
              "chatroom": (context) {
                return ChatRoom();
              },
              "graph": (context) {
                return LineChartSample2();
              }
            },
          );

          /* if(snapshot.hasError){
            print(snapshot.error);
            return MaterialApp(
              home: Scaffold(
                body: Text(snapshot.error.toString()),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return MaterialApp(home: Home());
          }
          return MaterialApp(home: Home());*/
        });
  }
}

class OldMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      home: Home(),
      routes: {
        'services': (context) {
          return Services();
        },
        'login': (context) {
          return SignIn(null);
        },
        'homepage': (context) {
          return Home();
        },
        "users": (context) {
          return Users();
        },
        "usersdetails": (context) {
          return UsersDetails();
        },
        "statistics": (context) {
          return Statistics();
        },
        "graph": (context) {
          return BarChartSample1();
        }
      },
    );
  }
}


/*
MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      home: Home(),
      routes:{
        'services':(context){
          return Services();
        },
        'login':(context){
          return SignIn();
        },
        'homepage':(context){
          return Home();
        },
        "users":(context){
          return Users();
        },
        "usersdetails":(context){
          return UsersDetails();
        },
        "statistics":(context){
          return Statistics();
        }
      },
    )
* */
