import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text("Menu"),
          decoration: BoxDecoration(
            color: Colors.cyan,
          ),
        ),
        ListTile(
          title: Text("Sign in"),
          leading: Image.asset("assets/images/user.png",
          width: 40,
            height: 40,
          ),
          onTap:(){
            Navigator.of(context).pushNamed("login");
          },
        ),
        ListTile(
          //enableFeedback: true,
          title: Text("Test graph"),
          leading: Image.asset("assets/images/user.png",
            width: 40,
            height: 40,
          ),
          onTap:(){
            Navigator.of(context).pushNamed("graph");
          },
        ),
        ListTile(
          //enableFeedback: true,
          enabled: FirebaseAuth.instance.currentUser==null,
          title: Text("Register"),
          leading: Image.asset("assets/images/document.png",
            width: 40,
            height: 40,
          ),
          onTap:(){
            Navigator.of(context).pushNamed("register");
          },
        ),
        ListTile(

          title: Text("Add a Company"),
          leading: Image.asset("assets/images/company.png",
            width: 40,
            height: 40,
          ),
          onTap:(){
            Navigator.of(context).pushNamed("companyadd");
          },
        ),
        ListTile(

          title: Text("Ask a Doctor"),
          leading: Image.asset("assets/images/chatbot.png",
            width: 40,
            height: 40,
          ),
          onTap:(){
            Navigator.of(context).pushNamed("chatroom");
          },
        ),
        ListTile(
          title: Text("Services"),
          leading: Icon(Icons.design_services, color: Colors.cyan,size:25)
          ,onTap:(){
            Navigator.of(context).pushNamed('services');
          },
        ),
        ListTile(
          title: Text("Record My Situation"),
          leading: Icon(Icons.person_outline, color: Colors.cyan,size:25)
          ,onTap:(){
          Navigator.of(context).pushNamed('recordsit');
        },
        ),
      ],
    ),
  );
}
}
