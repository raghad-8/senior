import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app1/Services/crudUser.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

class RecordCovid extends StatefulWidget {
  @override
  _RecordCovidState createState() => _RecordCovidState();
}

class _RecordCovidState extends State<RecordCovid> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CalendarController _CController = CalendarController();
  /*final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _CController = TextEditingController();
  final TextEditingController _HController = TextEditingController();
  final TextEditingController _iController = TextEditingController();*/

  bool? _C = false;
  bool? _H = false;
  bool? _i = false;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record My Situation"),
      ),
      body: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Record Situation',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Text("Do you hsvr cough?"),
                          secondary: Icon(Icons.outdoor_grill_outlined),
                            value: this._C,
                            onChanged: (bool? val) {
                              setState(() {
                                this._C = val;
                              });
                            }),
                        CheckboxListTile(
                          title: Text("Do yoou have headache?"),
                            secondary: Icon(Icons.hearing_disabled_sharp),
                            value: this._H,
                            onChanged: (bool? val) {
                              setState(() {
                                this._H = val;
                              });
                            }),
                        CheckboxListTile(
                            title: Text("Are yyou infected?"),
                            secondary: Icon(Icons.opacity_sharp),
                            value: this._i,
                            onChanged: (bool? val) {
                              setState(() {
                                this._i = val;
                              });
                            })
                      ],
                    ),
                    Container(
                      child:Text("$start to $end"),
                    ),
                    Row(
                      children: [

                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(onPressed: ()=>_selectDate1(context),child:
                          Text("Select the Starting date")
                          ,)
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(onPressed: ()=>_selectDate2(context),child:
                        Text("Select the ending date")
                          ,)
                      ],
                    ),
                  TableCalendar(
                    calendarController: _CController,
                    startDay: DateTime.utc(2010, 10, 16),
                    endDay: DateTime.utc(2030, 3, 14),
                    initialSelectedDay: DateTime.now(),
                  ),

                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: Text('Record'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var id = FirebaseAuth.instance.currentUser.uid;
                            await addCovidRecord(id, _C, _H,_i,start, end);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      //initialEntryMode: DatePickerEntryMode.input
    );

    if(picked!=null && picked!=start)
      setState(() {
        start = picked;
      });
  }

  _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: end,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if(picked!=null && picked!=end)
      setState(() {
        end = picked;
      });
  }
}
