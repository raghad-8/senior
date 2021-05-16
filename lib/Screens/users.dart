import 'package:app1/Services/crudUser.dart';
import 'package:flutter/material.dart';


class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List: "),
      ),body: UsersList(),
      //bottomNavigationBar: Text("Hello"),
    );
  }
}







/*class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

  var mlist = [{
    'user_id':'2',
   'Fname':'Baba',
    'Lname': 'Mama',
    'DOB':'10/6/2000',
    'Email':'mjeahs1234@gmail.com',
    'type':'student'
  },
    {
      'user_id':'2',
      'Fname':'Hussain',
      'Lname': 'Ghani',
      'DOB':'8/10/1997',
      'Email':'Love@gmail.com',
      'type':'hearts'
    },
    {
      'user_id':'3',
      'Fname':'Love',
      'Lname': 'MA',
      'DOB':'8/10/1111',
      'Email':';lj@gmail.com',
      'type':'nothinf'
    },

  ];

  Future getData() async {
    var url = "http://10.0.2.2/Flutter/test.php";
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    print(responsebody);
    return responsebody;
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Directionality(textDirection: TextDirection.ltr, child:Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context,i){
                return Mlist(id: snapshot.data[i]['user_id'], fname:snapshot.data[i]['Fname'], lname: snapshot.data[i]['Lname'],email:snapshot.data[i]['Email'], dob:snapshot.data[i]['DOB'], type: snapshot.data[i]['type'],) ;
              },

            );
          }
            return Center(child: CircularProgressIndicator());


        },
      )
    ) );
  }
}

*/