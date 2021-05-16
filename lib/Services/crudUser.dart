import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'User.dart';

CollectionReference users = FirebaseFirestore.instance.collection('users');
CollectionReference companies = FirebaseFirestore.instance.collection('companies');
CollectionReference records = FirebaseFirestore.instance.collection('covidrecords');
CollectionReference messages = FirebaseFirestore.instance.collection('messages');
CollectionReference doctors = FirebaseFirestore.instance.collection('doctors');
class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  user? _userfromfb(User user1){
    return user1 !=null ? user(user1.uid):null;
  }

  Future signInNormal(String email,String pass) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      )).user;

      return _userfromfb(user);

    } catch (e) {
      return e;
    }
  }

  Future<bool> userExists(String username) async =>
      (await users.where("username", isEqualTo: username).get()).docs.length > 0;

  Future signInWithGoogle() async {
    try {
      UserCredential userCredential;


        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final OAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;

      //0if(users.where("username", isEqualTo: user.e).get() ==null){
        addUser(user.uid, user.email,5);
      //}

      return _userfromfb(user);

    } catch (e) {
      return e;
    }
  }

  Future register(String email,String pass) async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      )).user;
      addUser(user.uid, email,5);
      return _userfromfb(user);
    } catch (e) {
      return e.toString();
    }
  }

  Future ResetPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      return e.toString();
    }
  }

  Future signout() async {
    try{
      return await _auth.signOut();
    }catch(e){
      return e.toString();
    }
  }
}

Future<void> addUser(id, company, age) {

  // Call the user's CollectionReference to add a new user
  return users
      .doc(id).set({
    'user_id': id, // John Doe
    'username': company, // Stokes and Sons
    'age': age // 42
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> addCompany(name, type, address) {

  // Call the user's CollectionReference to add a new user
  return companies
      .add({ // John Doe
    'name': name, // Stokes and Sons
    'type': type,
    'address': address// 42
  })
      .then((value) => print("Company Added"))
      .catchError((error) => print("Failed to add company: $error"));
}

Future<void> chatRoom(name, id) {

  // Call the user's CollectionReference to add a new user
  return doctors.add({ // John Doe
    'name': name, // Stokes and Sons
    'id': id,
  })
      .then((value) => print("doctor Added"))
      .catchError((error) => print("Failed to add company: $error"));
}

Future<void> getUsers() async {
  final QuerySnapshot result =
      await FirebaseFirestore.instance.collection('users').get();

  final userRef = FirebaseFirestore.instance.collection('users');

  return userRef.get().then((snapshot) {
    snapshot.docs.forEach((doc) {
      print(doc.data);
    });
  });



  /*final List<DocumentSnapshot> documents = result.docs;
//print("Hello");
  return documents.forEach((data) => print(data));*/

  /*return users
      .add({
    'id': id, // John Doe
    'name': name, // Stokes and Sons
    'type': type,
    'address': address// 42
  })
      .then((value) => print("Company Added"))
      .catchError((error) => print("Failed to add company: $error"));*/
}

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['age'].toString()),
              subtitle: new Text(document.data()['username'].toString()),
              trailing: new Text(document.data()['user_id'].toString()),
            );
          }).toList(),
        );
      },
    );
  }
}

Future<void> addCovidRecord(id, cough, headache,infected, start,end) {

  CollectionReference rec = users.doc(id).collection("covidrecord");
  // Call the user's CollectionReference to add a new user
  return rec
      .add({
     //'userid': id,
    'cough': cough,
    'headache': headache,
    'infected': infected,
    'start' : start,
    'end' : end
  })
      .then((value) => print("Record Added"))
      .catchError((error) => print("Failed to add record: $error"));


}



