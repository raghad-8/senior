import 'package:flutter/material.dart';
import 'package:app1/Services/crudUser.dart';
class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final TextEditingController _nameController1 = TextEditingController();
  final TextEditingController _typeController1 = TextEditingController();
  final TextEditingController _addressController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ask a Doctor"),
      ),
      body: Form(
          key: _formKey1,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController1,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (String? value) {
                    },
                  ),
                  TextFormField(
                    controller: _typeController1,
                    decoration: const InputDecoration(labelText: 'id'),
                    validator: (String? value) {
                    },
                    //obscureText: true,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text('add dr'),
                      onPressed: () async {
                        if (_formKey1.currentState!.validate()) {
                          await chatRoom(_nameController1.text, _typeController1.text);
                        }
                      },

                    ),

                  ),
                ],
              ),
            ),
          )),
    );
  }
}

