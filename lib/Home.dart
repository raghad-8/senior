import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Components/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text("Covid-19"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /*Center(
                child: Image.asset('assets/images/download.jpg'),
              ),*/
              Container(
                padding: EdgeInsets.all(10),
                child: Text("Services: ", style: TextStyle(fontSize:30 , color: Colors.cyan),),
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal ,
                  children: [
                    InkWell(
                      child:Container(
                        height: 150,
                        width: 150,
                        child: ListTile(
                          title: Image.asset("assets/images/teamwork.png", width: 80, height: 80,),
                          subtitle: Text("Users", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),),
                        ),) ,
                      onTap: (){
                        Navigator.of(context).pushNamed("users");
                      },
                    ),InkWell(
                      child:  Container(
                        height: 150,
                        width: 150,
                        child: ListTile(
                          title: Image.asset("assets/images/graph.png",width: 80, height: 80, ),
                          subtitle: Text("Statistics", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),),
                        ),), onTap: (){
                      Navigator.of(context).pushNamed("statistics");
                    },
                    ), InkWell(
                      child:  Container(
                        height: 100,
                        width: 150,
                        child: ListTile(
                          title: Image.asset("assets/images/news.png",width: 80, height: 80, ),
                          subtitle: Text("News", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700)),
                        ),),onTap: (){
                      Navigator.of(context).pushNamed("news");
                    },
                    ), InkWell(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ListTile(
                          title: Image.asset("assets/images/calendar.png",width: 80, height: 80, ),
                          subtitle: Text("My Situation", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),),
                        ),),onTap: (){},
                    ),/*InkWell(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: ListTile(
                          title: Image.asset("assets/images/map.png",width: 80, height: 80, ),
                          subtitle: Text("Map", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),),
                        ),),onTap: (){},
                    )*/
                  ] ,
                ),
              ),
            ],
          ),
        )
    );
  }
}
