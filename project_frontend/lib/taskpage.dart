import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  void clearField(TextEditingController text) {
    setState(() {
      text.clear();
    });
  }
  DateTime selectedDate = DateTime.now();


  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Background blurred content
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            //   child: Container(
            //     color: Colors.black
            //         .withOpacity(0.3), // Adjust the opacity as needed
            //   ),
            // ),
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 500,
                height: 520,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Align elements to the start and end of the row
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "Add a Task",
                          style: TextStyle(
                            fontFamily: "Myfont",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Text(
                      "ENTER TITLE:",
                      style: TextStyle(
                        fontFamily: "Myfont",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 390,
                      child: TextField(
                         cursorColor: Colors.black,
                       
                        controller: title,
                        decoration: InputDecoration(
                          
                          hintText: "Required",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic,fontSize: 14),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                clearField(title);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              )),
                          contentPadding: EdgeInsets.all(15.0),
                          filled: true,
                          fillColor: Colors.grey[300],
                          // labelText: 'Task Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "ENTER DESCRIPTION:",
                      style: TextStyle(fontFamily: "Myfont"),
                    ),
                    Container(
                      width: 390,
                      height: 150,
                      child: TextField(
                        controller: description,
                        textAlignVertical: TextAlignVertical.top,
                        cursorColor: Colors.black,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: "Optional",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic,fontSize: 14),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                clearField(description);
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                              )),
                          filled: true,
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "DUE DATE:",
                      style: TextStyle(fontFamily: "Myfont"),
                    ),
                    Container(
                      width: 390,
                      child: GestureDetector(
                        onTap: () async{
                          DateTime? pickedDate = await showDatePicker(
                            
                      context: context,
                      
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), // DateTime.now() - not to allow choosing before today.
                      lastDate: DateTime(2101),
                      builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.black, // <-- SEE HERE
            onPrimary: Colors.white, // <-- SEE HERE
            onSurface: Colors.black, // <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
                    );

                    if (pickedDate != null) {
                      String formatdate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dueDate.text = formatdate;
                      });
                    }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                             cursorColor: Colors.black,
                       
                            controller: dueDate,
                            decoration: InputDecoration(
                              hintText: "Required",
                          hintStyle: TextStyle(fontStyle: FontStyle.italic,fontSize: 14),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    clearField(dueDate);
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                  )),
                                              
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.all(15.0),
                              filled: true,
                              fillColor: Colors.grey[300],
                              // labelText: 'Task Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 50,
                      //width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          var formattedDueDate =
                              DateFormat('yyyy-MM-dd').parse(dueDate.text);

                          var bool = await addTask(token, title.text,
                              description.text, formattedDueDate);
                          if (bool) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(
                                  child: Text(
                                "Task added successfully!",
                                style: TextStyle(fontFamily: "Myfont"),
                              )),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.black,
                            ));
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)))),
                        child: Text(
                          "CONFIRM AND ADD",
                          style: TextStyle(
                              fontFamily: "Myfont",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InN0cmluZyIsImVtYWlsIjoiOCIsIm5iZiI6MTY5NTExOTQyOCwiZXhwIjoxNjk1MTU1NDI4LCJpYXQiOjE2OTUxMTk0MjgsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiJ9.Lg6JUORcg0I4r7e8EORBapFyx8sBdhlROED8bP9C9Fw";
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(100.0),
          //   child: ListView.builder(
          //     physics: BouncingScrollPhysics(),
          //     itemCount: tasks.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       Taskobjects task = tasks[index];
          //       DateTime dueDate = DateTime.parse(task.dueDate);
          //       var formatteddate = DateFormat('dd-MM-yyyy').format(dueDate);
          //       return FractionallySizedBox(
          //         widthFactor: 0.8,
          //         child: Container(
          //           height: 80,
          //           // width: 200,
          //           // padding: EdgeInsets.all(5),
          //           margin: EdgeInsets.all(
          //               10), // Add margin for spacing between tasks
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius:
          //                 BorderRadius.circular(20), // Add rounded corners
          //             boxShadow: [
          //               // BoxShadow(
          //               //   color: Colors.grey.withOpacity(0.5), // Add shadow color
          //               //   spreadRadius: 3,
          //               //   blurRadius: 5,
          //               //   offset: Offset(0, 3), // Add shadow offset
          //               // ),
          //             ],
          //           ),
          //           child: Text(task.description,style: TextStyle(fontFamily: "Myfont",fontWeight: FontWeight.bold),),
          //         ),
          //       );
          //     },
          //   ),
          // ),
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
                      splashFactory: NoSplash.splashFactory,
                        backgroundColor: Color.fromARGB(195, 3, 4, 46),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      _showDialog(context);
                    },
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
