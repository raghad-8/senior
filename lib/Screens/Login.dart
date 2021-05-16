// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

// ignore_for_file: deprecated_member_use

import 'package:app1/Services/crudUser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for various sign-in flows with Firebase.
class SignIn extends StatefulWidget {
  final Function togg;

  /// The page title.
  final String title = 'Sign In & Out';

  @override
  State<StatefulWidget> createState() => _SignInState();

  SignIn(this.togg);
}

class _SignInState extends State<SignIn> {

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final User user = _auth.currentUser;
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _signOut();

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('$uid has successfully signed out.'),
                ));
              },
              child: const Text('Sign out'),
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            _EmailPasswordForm(),
           // _EmailLinkSignInSection(),
            //_AnonymouslySignInSection(),

            _OtherProvidersSignInSection(),
          ],
        );
      }),
    );
  }

  // Example code for sign out.
  Future<void> _signOut() async {
    await _auth.signOut();
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

Auth methods = new Auth();

bool isLoading = false;

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: isLoading?Container(
          child: Center(child: CircularProgressIndicator())
        ): Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign in with email and password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (String value) {
                    if (value.isEmpty) return 'Please enter some text';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: SignInButton(
                    Buttons.Email,
                    text: 'Sign In',
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isLoading = false;
                        });
                        methods.signInNormal(_emailController.text, _passwordController.text).then((value) {
                          String v;
                          if(value.code == "user-not-found")
                            v = "You are not registered!";
                          else if(value.code == "wrong-password")
                            v = "Your password is incorrect";
                          else
                            v = value.code;
                          print("$value");
                          setState(() {
                            isLoading = false;
                          });
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$v"),
                            ),
                          );

                          //Navigator.pushReplacementNamed(context, 'homepage');
                        }
                        );


                      }
                    },
                  ),
                ),
               RichText(
          text: TextSpan(

              children: <TextSpan>[
              TextSpan(text: 'Dont have an account?',style: TextStyle(color: Colors.black)),
          TextSpan(
              text: 'Register',
              style: TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(context, "register");
                }),
              ],

            ),
          ),
        ]))));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  /*Future<void> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${user.email} signed in'),
        ),
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email & Password'),
        ),
      );
    }
  }*/
}
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

class _OtherProvidersSignInSection extends StatefulWidget {
  _OtherProvidersSignInSection();

  @override
  State<StatefulWidget> createState() => _OtherProvidersSignInSectionState();
}

class _OtherProvidersSignInSectionState
    extends State<_OtherProvidersSignInSection> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Text('Social Authentication',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Center(
                child: SignInButton((Buttons.GoogleDark),
                  text: 'Sign In',
                  onPressed: () async {
                    methods.signInWithGoogle().then((value) {
                      String v;
                      /*if(value.code == "user-not-found")
                        v = "You are not registered!";
                      else if(value.code == "wrong-password")
                        v = "Your password is incorrect";
                      else
                        v = value.code;*/
                      //print("$value");
                      setState(() {
                        isLoading = false;
                      });
                      /*Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$v"),
                        ),
                      );*/

                      //Navigator.pushReplacementNamed(context, 'homepage');
                    });
                    //Navigator.pushReplacementNamed(context, 'homepage');
                  },
                ),

              )

              ]),

    ));
  }


  //Example code of how to sign in with Google.

}