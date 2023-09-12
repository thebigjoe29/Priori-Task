import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String urllogin = "http://localhost:5042/LoginPage/Authentication";
String urlsignup = "http://localhost:5042/LoginPage/Signup";
String urltasks = "http://localhost:5042/Task/getUserTask";
var token;
var message;

class Authentication {
  final Token;
  final Message;
  Authentication(this.Token, this.Message);
}
class Taskobjects{
  final taskId;
  final title;
  final description;
  final dueDate;
  Taskobjects(this.taskId,this.title,this.description,this.dueDate);
}

Future signupUser(String user, String pass, String firstname) async {
  try {
    var url = Uri.parse(urlsignup);
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': user,
        'password': pass,
        'firstname': firstname,
      }),
    );

    var data = response.body;
    return (data);
  } catch (e) {
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

    var data = response.body;
    if (response.statusCode == 200) {
      token = jsonDecode(data)["token"];
      message = jsonDecode(data)["message"];
      Authentication authobj = Authentication(token, message);
      return authobj;
    } else {
      return data;
    }
  } catch (e) {
    print("Error: $e");
  }
}

Future getTasks(String headerToken) async {
  try {
    var url = Uri.parse(urltasks);
    var headers = {
      'Authorization': 'Bearer $headerToken', // Add the Bearer token here
    };
    var response = await http.get(url, headers: headers);
    var data = response.body;
    if(response.statusCode==200){
      final List<dynamic> tasklist= jsonDecode(data);
      List <Taskobjects> tasks=[];
      for(var i in tasklist){
        Taskobjects obj=Taskobjects(i["taskId"],i["title"],i["description"],i["dueDate"]);
        tasks.add(obj);
      }
      return tasks;
    }
    else{
      return data;
    }
   
   
   
  } catch (e) {
    print(e);
  }
}

// void main () async{
// List <Taskobjects> tasks=[];
// var result=await getTasks("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InEiLCJlbWFpbCI6IjciLCJuYmYiOjE2OTQ0MjMxMDYsImV4cCI6MTY5NDQyNjcwNiwiaWF0IjoxNjk0NDIzMTA2LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjUwNDIiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjUwNDIifQ.KfdqxHWAGHU4o-mcl0qlnJ8BC2WyCmm6DIudA2dgOQg");
// if(result is List<Taskobjects>){
//   tasks=result;
// }
// for (var task in tasks) {
//     print("Task ID: ${task.taskId}");
//     print("Title: ${task.title}");
//     print("Description: ${task.description}");
//     DateTime dueDate = DateTime.parse(task.dueDate);
//     var formatteddate=DateFormat('dd-MM-yyyy').format(dueDate);
//     print("Due Date: "+formatteddate);
//     print("--------------");
//   }
// }


