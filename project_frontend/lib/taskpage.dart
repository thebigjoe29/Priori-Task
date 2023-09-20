import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'networking_api.dart';
import 'package:intl/intl.dart';
import 'networking_api.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

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
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black
                    .withOpacity(0.3), // Adjust the opacity as needed
              ),
            ),
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
                            clearField(title);
                            clearField(description);
                            clearField(dueDate);
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
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
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
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
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
                        onTap: () async {
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
                                      foregroundColor:
                                          Colors.black, // button text color
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
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
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
                            clearField(title);
                            clearField(description);
                            clearField(dueDate);
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
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InN0cmluZyIsImVtYWlsIjoiOCIsIm5iZiI6MTY5NTE4ODU0MCwiZXhwIjoxNjk1MjI0NTQwLCJpYXQiOjE2OTUxODg1NDAsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTA0MiJ9.IM8VVfVYxRZK14JNBfXDFQuXfgNLSE1udOdVS-Mtj9Q";
  int _selectedIndex = 0; // Initially select the first tab

  final List<String> _tabs = ["Pending", "Completed"];
  late DateTime today;
  String day = '';
  String date = '';
  String month = '';
  String year = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadtasks();
    today = DateTime.now();
    day = DateFormat('EEEE').format(today);
    date = DateFormat('d').format(today);
    month = DateFormat('MMMM').format(today);
    year = DateFormat('yyyy').format(today);
//print(day+date+month+year);
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
          Positioned.fill(
            child: Image.asset(
              "images/bg3.jpg", // Replace with your image asset path
              fit: BoxFit.cover, // Cover the entire stack with the image
            ),
          ),
          Positioned(
            top: 20,
            left: 140,
            child: Container(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: const Color.fromARGB(255, 244, 67, 54),
                    size: 60,
                  )),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 100,
                width: 900,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.7)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello Eshaan!",
                          style: TextStyle(
                              fontFamily: "Myfont",
                              fontSize: 35,
                              color: Colors.black),
                        ),
                        Text("It's good to see you again.",
                            style: TextStyle(
                                fontFamily: "Myfont",
                                fontSize: 10,
                                color: Colors.purple))
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Container(
                      height: 100,
                      width: 0.5,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    SizedBox(
                      width: 110,
                    ),
                    Text("TASK DASHBOARD",
                        style: TextStyle(
                            fontFamily: "Myfont",
                            fontSize: 40,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 70,
            child: Container(
              height: 100,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                        fontFamily: "Myfont",
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                  Text(
                    date + " " + month + " " + year,
                    style: TextStyle(
                        fontFamily: "Myfont",
                        fontWeight: FontWeight.w300,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 145,
              left: 0,
              right: 0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: 500,
                      width: 1200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      child: DefaultTabController(
                        length: _tabs.length,
                        initialIndex: _selectedIndex,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: _tabs.map((String tabTitle) {
                                return Tab(text: tabTitle,);
                              }).toList(),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black,
                              labelStyle: TextStyle(fontFamily: "Myfont"),
                              unselectedLabelStyle:TextStyle(fontFamily: "Myfont"), 
                             padding: EdgeInsets.all(3),
                             indicator: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 22, 101, 24).withOpacity(0.2),
                             ),
                            ),
                            Expanded(
                                child: TabBarView(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: Center(child:Text("These are pending tasks")),
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Center(child:Text("These are completed tasks")),
                                )
                              ],
                            ))
                          ],
                        ),
                      )),
                ),
              )),
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
              top: 670,
              left: 0,
              right: 0,
              child: Center(
                  child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(100)
                    ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      //backgroundColor: Color.fromARGB(195, 3, 4, 46),
                      backgroundColor: Colors.black.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Create Task",
                          style: TextStyle(fontFamily: "Myfont", fontSize: 26),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          height: 55,
                          width: 55,
                          //  color: Colors.white,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )))
        ],
      ),
    );
  }
}
