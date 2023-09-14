import 'package:flutter/material.dart';
import 'networking_api.dart';
import 'package:intl/intl.dart';
import 'networking_api.dart';

class Tasks extends StatefulWidget {
  //final logintoken;
  Tasks({Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<Taskobjects> tasks = [];
  var result;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InN0cmluZyIsImVtYWlsIjoiOCIsIm5iZiI6MTY5NDUwODI3OCwiZXhwIjoxNjk0NTQ0Mjc4LCJpYXQiOjE2OTQ1MDgyNzgsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiJ9.xllxGKRUD2xBdpai4eRzNn-EG9oc9e6c24gAEqDLzMM";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadtasks();
  }

  Future _loadtasks() async {
    try {
      result = await getTasks(token);
      if (result is List<Taskobjects>) {
        setState(() {
          tasks = result;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                Taskobjects task = tasks[index];
                DateTime dueDate = DateTime.parse(task.dueDate);
                var formatteddate = DateFormat('dd-MM-yyyy').format(dueDate);
                return FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    height: 80,
                    // width: 200,
                    // padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(
                        10), // Add margin for spacing between tasks
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20), // Add rounded corners
                      boxShadow: [
                        // BoxShadow(
                        //   color: Colors.grey.withOpacity(0.5), // Add shadow color
                        //   spreadRadius: 3,
                        //   blurRadius: 5,
                        //   offset: Offset(0, 3), // Add shadow offset
                        // ),
                      ],
                    ),
                    child: Text(task.description,style: TextStyle(fontFamily: "Myfont",fontWeight: FontWeight.bold),),
                  ),
                );
              },
            ),
          ),
          Positioned(
              top: 650,
              left: 0,
              right: 0,
              child: Center(
                  child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(100)
                    ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(195, 3, 4, 46),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      size: 50,
                      color: Colors.white,
                    )),
              )))
        ],
      ),
    );
  }
}
