import 'package:app1/Services/crudUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
class CompanyAdd extends StatefulWidget {
  @override
  _CompanyAddState createState() => _CompanyAddState();
}

class _CompanyAddState extends State<CompanyAdd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Company"),
      ),
      body: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Add a company',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Please enter the company name';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _typeController,
                    decoration: const InputDecoration(labelText: 'type'),
                    validator: (String? value) {
                      if ((value!.isEmpty)|| (value.toLowerCase() != "company" )) return 'Please enter Company';
                      return null;
                    },
                    //obscureText: true,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'address'),
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Please enter the address';
                      return null;
                    },
                    //obscureText: true,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: Text('Sign In'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await addCompany(_nameController.text, _typeController.text, _addressController.text);
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

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _typeController.dispose();
    super.dispose();
  }


}
