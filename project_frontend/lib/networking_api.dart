import 'dart:convert';
import 'package:http/http.dart' as http;

String urllogin = "http://localhost:5042/LoginPage/Authentication";
String urlsignup="http://localhost:5042/LoginPage/Signup";
var token;
var message;

Future signupUser(String user,String pass,String firstname) async{
  try{
    var url=Uri.parse(urlsignup);var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user,
        'password': pass,
        'firstname':firstname,
      }),
    );
    var data=response.body;
    return data;
   
    
  }
  catch(e){
    print(e);
  }
}

Future authenticateUser(String user, String pass) async {
  try {
    var url = Uri.parse(urllogin);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user,
        'password': pass,
      }),
    );

    if (response.statusCode == 200) {
      message = jsonDecode(response.body)["message"];
       token = jsonDecode(response.body)["token"];
      
    } 
    return token;
  } catch (e) {
    print("Error: $e");
  }
}



