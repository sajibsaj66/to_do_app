import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../db/db_helper.dart';
import '../models/todo-model.dart';
class TodoProvider extends ChangeNotifier{

  Future<List<TodoModel>> getAllData() async {
    final allData =  await DBHelper.getAllData();
    notifyListeners();
    return allData;
  }


  Future<bool> insertTodoTask(TodoModel todoModel) async {
    final rowId =  await DBHelper.insertTodoTask(todoModel);
    if(rowId > 0){
      todoModel.id = rowId;
      notifyListeners();
      return true;
    }
    return false;
  }


}