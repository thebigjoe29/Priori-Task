import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

String urllogin = "http://localhost:5042/LoginPage/Authentication";
String urlsignup = "http://localhost:5042/LoginPage/Signup";
String urltasks = "http://localhost:5042/Task/getUserTask";
String urladdtask = "http://localhost:5042/Task/insertUserTask";
String urlCompletedtasks = "http://localhost:5042/Task/getUserCompletedtask";
String urltickButton = "http://localhost:5042/Task/completeUserTask";
String urlDeleteTask="http://localhost:5042/Task/deleteUserTask";
String urlundo="http://localhost:5042/Task/undoCompletedTask";
var token;
var message;
var username;
class UserData {
  final String logintoken;
  final String username;

  UserData({required this.logintoken, required this.username});
}
class signupstate {
  final success;
  final data;
  signupstate(this.success, this.data);
}

class Authentication {
  final Token;
  final Message;
  final Name;
  Authentication(this.Token, this.Message, this.Name);
}

class Taskobjects {
  final taskId;
  final title;
  final description;
  final dueDate;
  Taskobjects(this.taskId, this.title, this.description, this.dueDate);
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

    if (response.statusCode == 200) {
      signupstate obj = signupstate(true, data);
      return obj;
    } else {
      signupstate obj = signupstate(false, data);
      return obj;
    }
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
      username = jsonDecode(data)["name"];
      Authentication authobj = Authentication(token, message, username);
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
    if (response.statusCode == 200) {
      final List<dynamic> tasklist = jsonDecode(data);
      List<Taskobjects> tasks = [];
      for (var i in tasklist) {
        Taskobjects obj = Taskobjects(
            i["taskId"], i["title"], i["description"], i["dueDate"]);
        tasks.add(obj);
      }
      return tasks;
    } else {
      return data;
    }
  } catch (e) {
    print(e);
  }
}

Future getTasksCompleted(String headerToken) async {
  try {
    var url = Uri.parse(urlCompletedtasks);
    var headers = {
      'Authorization': 'Bearer $headerToken', // Add the Bearer token here
    };
    var response = await http.get(url, headers: headers);
    var data = response.body;
    if (response.statusCode == 200) {
      final List<dynamic> tasklist = jsonDecode(data);
      List<Taskobjects> tasks = [];
      for (var i in tasklist) {
        Taskobjects obj = Taskobjects(
            i["taskId"], i["title"], i["description"], i["dueDate"]);
        tasks.add(obj);
      }
      return tasks;
    } else {
      return data;
    }
  } catch (e) {
    print(e);
  }
}

Future addTask(String headerToken, String title, String description,
    DateTime dueDate) async {
  try {
    var url = Uri.parse(urladdtask);
    var headers = {
      'Authorization': 'Bearer $headerToken',
      'Content-Type': 'application/json', // Add the Bearer token here
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
}

Future tickButton(String headerToken, int id) async {
  try {
    var url = Uri.parse(urltickButton + "?id=$id");
    var headers = {
      'Authorization': 'Bearer $headerToken',
      'Content-Type': 'application/json', // Add the Bearer token here
    };
    var response = await http.put(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
}
Future deleteUserTask(String headerToken,int id)async{
  try{
     var url = Uri.parse(urlDeleteTask + "?id=$id");
    var headers = {
      'Authorization': 'Bearer $headerToken',
      'Content-Type': 'application/json', // Add the Bearer token here
    };
    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  catch(e){
    print(e);
  }
}

Future undoCompletedTask(String headerToken,int id)async{
   try {
    var url = Uri.parse(urlundo + "?id=$id");
    var headers = {
      'Authorization': 'Bearer $headerToken',
      'Content-Type': 'application/json', // Add the Bearer token here
    };
    var response = await http.put(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
}

void main() async {
  var poop = await tickButton(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InN0cmluZyIsImVtYWlsIjoiOCIsIm5iZiI6MTY5NTM2NDYwMywiZXhwIjoxNjk1NDAwNjAzLCJpYXQiOjE2OTUzNjQ2MDMsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiJ9.w7hOtql473_shvAnBVYF6HNRbajR1nKZFElSdYqOa-g",
      25);
  print(poop);
}



