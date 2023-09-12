import 'package:flutter/material.dart';
import 'networking_api.dart';
import 'package:intl/intl.dart';

class Tasks extends StatefulWidget {
  final logintoken;
  Tasks(this.logintoken, {Key? key}) : super(key: key);

  @override
  
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<Taskobjects> tasks = [];
  var result;
  @override
  void initState() {
    // TODO: implement initState  
    super.initState();
    _loadtasks();
   
  }
   
  Future _loadtasks()async{
 try{
result= await getTasks(widget.logintoken);
    if(result is List<Taskobjects>){
    setState(() {
      tasks=result;
    });}
 }
 catch(e){
  print(e);
 }
  }
  
  @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            Taskobjects task = tasks[index];
            DateTime dueDate = DateTime.parse(task.dueDate);
           var formatteddate= DateFormat('dd-MM-yyyy').format(dueDate);
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(task.title),
                  Text(task.description),
                  Text(formatteddate),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}

}