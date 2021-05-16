import 'package:flutter_offline/flutter_offline.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Components/countrydetails.dart';

import 'package:country_list_pick/country_list_pick.dart';

class Statistics extends StatefulWidget {



  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  bool con = false;

  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final myController = TextEditingController();
  FocusNode? myFocusNode;
  List _cities = ["bahrain", "oman"];
  List<DropdownMenuItem<String>>? _dropDownMenuItems;
  String _currentCity = "bahrain";

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  void dispose() {
    myController.dispose();
    myFocusNode!.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();

    // Start listening to changes.
    myFocusNode = FocusNode();
    myController.addListener(_printLatestValue);
    _dropDownMenuItems = getDropDownMenuItems();
    //_currentCity = _dropDownMenuItems[0].value;

  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String city in _cities) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }
  Future getForC(String c) async {
    var url = "https://api.covid19api.com/country/"+c;
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

  void changedDropDownItem(String selectedCity){

    print("Selected city $selectedCity , we are going to refresh ui");
    setState(() {
      _currentCity = selectedCity;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("explore"),
      ),
      body: Column(
                children: [
                  FutureBuilder(
                    future: checkConn(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data =="I am connected to a wifi network."||snapshot.data =="I am connected to a mobile network."){
                          return Visibility(visible: false,child: Text(snapshot.data));
                        }
                        return Text(snapshot.data);
                      }else{
                        return Text("An error ocured");
                      }
        }
                  ),
                Container(
                      //padding:EdgeInsets.all(20),
                      //height:200,
                      alignment: Alignment.center,
                      child: Card(
                          child:Padding(
                            padding: EdgeInsets.all(5),
                            child:SizedBox(
                              width:double.infinity,
                              child:CountryListPick(
                                theme:  CountryTheme(
                                  //initialSelection:'BH',
                                  //initialSelection: 'Bahrain',
                                  isShowFlag: true,
                                  isShowTitle: true,
                                  isShowCode: false,
                                  isDownIcon: true,
                                  showEnglishName: true,
                                ),
                                onChanged: (CountryCode? code) {
                                  changedDropDownItem(code!.code!);

                                },
                              ),
                            ),
                          )
                      )
                  ),
                  dosom()

                ],
              ),
    );
  }

  FutureBuilder dosom(){
  return FutureBuilder(
  future: getForC(_currentCity),
  builder: (BuildContext context, AsyncSnapshot snapshot){

  if (snapshot.hasData){
    if(snapshot.data.length>0){
      return Expanded(
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: 1,
            itemBuilder: (context,i){
              print(i);
                return
                  Cdetails(date: snapshot.data[snapshot.data.length - (i+1)]['Date'],code: snapshot.data[snapshot.data.length - (i+1)]['CountryCode'], confirmed :(snapshot.data[snapshot.data.length - (i+1)]['Confirmed']-snapshot.data[snapshot.data.length - (i+3)]['Confirmed']), deaths: snapshot.data[snapshot.data.length - (i+1)]['Deaths'],recoverd:snapshot.data[snapshot.data.length - (i+1)]['Recovered'], active:snapshot.data[snapshot.data.length - (i+1)]['Active'],) ;
            },

          ),
        ),
      );
    }else{
      return Expanded(
          child: Center(child: Text("There is no data for this country", style: TextStyle(fontSize: 20, color: Colors.red,fontWeight: FontWeight.bold),))
      );
    }

  }
  return Center(child: CircularProgressIndicator());

  },
  );
}


Future<String> checkConn() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return "I am connected to a mobile network.";

  } else if (connectivityResult == ConnectivityResult.wifi) {

    return "I am connected to a wifi network.";
  }else{
    return "No internet Connection";
  }
}

}


