import 'package:flutter/material.dart';
class Cdetails extends StatelessWidget {

  final code;
  final confirmed;
  final deaths;
  final recoverd;
  final active;
  final date;


  Cdetails({this.date,this.code, this.confirmed, this.deaths, this.recoverd, this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        child: Card(
          child: Row(
            children: [
              /*Expanded(flex:1, child: Image.asset("assets/images/chatbot.png")),*/
              Expanded(flex:2, child: Container(
                alignment: Alignment.topLeft,
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:10, bottom:10),
                      child: Text(code.toString(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,),),
                    Row(
                      children: [
                        Expanded(child: Row(
                          children: [
                            Text("Active cases ",
                              style: TextStyle(color: Colors.green),),
                            Text(active.toString(),
                              style: TextStyle(color: Colors.green),)

                          ],
                        ),

                        ),
                        Expanded(child: Row(
                          children: [
                            Text("Deaths ",
                              style: TextStyle(color: Colors.green),),
                            Text(this.deaths.toString(),
                              style: TextStyle(color: Colors.red),),
                          ],
                        ),

                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Row(
                          children: [
                            Text("Date ",
                              style: TextStyle(color: Colors.orange),),
                            Text(this.date.toString(),
                              style: TextStyle(color: Colors.red),)

                          ],
                        ),

                        )
                      ],
                    )
                  ],
                ),
              ),)
            ],
          ),
        ),
      );
  }
}
