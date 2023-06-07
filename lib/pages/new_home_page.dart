import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



import '../constants.dart';
import '../db/db_helper.dart';
import '../models/todo-model.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

Future<List<TodoModel>> fetchData() async {
  return await DBHelper.getAllData();
}

class _NewHomePageState extends State<NewHomePage> {

  var taskNameController = TextEditingController();
  var taskTimeController = TextEditingController();
  var taskDeadLineController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? deadLine;


  @override
  void dispose() {
    taskNameController.dispose();
    taskTimeController.dispose();
    taskDeadLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                Center(child: Image.asset('images/homepage_bg.png')),
                Positioned(
                    top: 70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Todo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      ],
                    )),
                Positioned(
                  top: 150,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: FutureBuilder(
                          future: fetchData(),
                          builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    //split = snapshot.data![index].geners!.split(',');
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white10),
                                            color: kThemeColorLight,
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 2, right: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10, left: 5, right: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Deadline - ${snapshot.data![index].deadLine!}',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 10,
                                                              fontFamily: 'NotoSans'),
                                                        ),

                                                        Text(
                                                          snapshot.data![index].taskName!,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'NotoSans'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data![index].taskTime!,
                                                    style: TextStyle(fontSize: 11, color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,)
                                      ],
                                    );

                                  });
                            }
                            return Text('data');
                          }),
                    ),
                  ),
                ),
              ],
            ),
          )),
      /*Stack(
            children: [
              Center(child: Image.asset('images/homepage_bg.png')),
              Positioned(
                  top: 70,
                  left: 30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Todo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ],
                  )),
            ],
          )*/
      floatingActionButton: FloatingActionButton(
          backgroundColor: kThemeColorLight,
          child: Icon(Icons.edit),
          onPressed: () {
            showModalBottomSheet(context: context, builder: (context) =>
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Colors.white10,
                        ),
                        height: 50,
                        child: Center(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color:
                                          Colors.amber.shade700,
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Add Task',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      _saveInfo(context);
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                          color:
                                          Colors.amber.shade700,
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),

                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: kThemeColorLight,
                        ),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(
                                parent:
                                AlwaysScrollableScrollPhysics()),
                            child: Column(
                              //mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  controller: taskNameController,
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700,
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                    hintText: 'New Task',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white10, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: "New Task",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.title,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Task Name';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime:
                                        TimeOfDay
                                            .now())
                                        .then((value) =>
                                    taskTimeController
                                        .text =
                                        value!.format(
                                            context));
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.name,
                                  controller: taskTimeController,
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700,
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                    hintText: 'Task Time',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white10, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: "Task Time",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Task Time';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  onTap: () {
                                    _showDate(context);
                                  },
                                  keyboardType: TextInputType.datetime,
                                  controller: taskDeadLineController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700,
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                    hintText: 'Task DadeLine',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    contentPadding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 20),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white10, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    labelText: "Task DadeLine",
                                    labelStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter DeadLine';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 320,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                backgroundColor: kThemeColorLight);
          }),
    );
  }

  void _showDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100)
    );
    if (selectedDate != null) {
      setState(() {
        deadLine = DateFormat('dd/MM/yyyy').format(selectedDate);
        taskDeadLineController.text = deadLine!;
      });
    }
  }

  _saveInfo(BuildContext context,) async {
    if (formKey.currentState!.validate()) {
      final addTask = TodoModel(
          taskName: taskNameController.text,
          taskTime: taskTimeController.text,
          deadLine: taskDeadLineController.text
      );
      final rowId = await DBHelper.insertTodoTask(addTask);
      if(rowId > 0){
        addTask.id = rowId;
        Navigator.pop(context);
      }
    }
    setState(() {
      taskNameController.text = '';
      taskTimeController.text = '';
      taskDeadLineController.text = '';
    });
  }


}
