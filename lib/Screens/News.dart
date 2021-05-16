import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;


class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {

  static const _api_key = "71d54f9347msh4326267baca7e67p1dfc5ajsnb4c4cf17a004";
  // Base API url
  static const String _baseUrl = "https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/news";
  // Base headers for Response url
  static const Map<String, String> _headers = {
    "content-type": "application/json",
    "x-rapidapi-host": "vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com",
    "x-rapidapi-key": _api_key,
  };

  // Base API request to get response
  Future<dynamic> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, pa
      // rse the JSON.
      print(response.body);
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return     FutureBuilder(
      future:get(endpoint:'/get-vaccine-news/0', query:{}),
      builder: (BuildContext context, AsyncSnapshot snapshot){

        if (snapshot.hasData){
          return Expanded(
            child: Text(snapshot.data.toString()),
          );
        }else{
          print("no");
        }
        return Center(child: CircularProgressIndicator());


      },
    );
  }
}
