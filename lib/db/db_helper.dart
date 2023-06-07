import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


import '../models/todo-model.dart';



class DBHelper{
  static const String createTableTodo='''
  create table $tableTodo(
  $tableColId integer primary key,
  $tableColTaskName String,
  $tableColTaskTime String,
  $tableColDeadLine String
  )
  ''';

  static Future<Database> open() async{
    final rootPath = await getDatabasesPath();
    final dbPath =join(rootPath,'todo.db');

    return openDatabase(dbPath,version: 1,onCreate:(db,version){
      db.execute(createTableTodo);
    } );
  }


  static Future<int> insertTodoTask(TodoModel todoModel) async{
    final db = await open();
    return db.insert(tableTodo, todoModel.toMap());
  }


  static Future<List<TodoModel>> getAllData() async{
    final db = await open();
    var mapList = await db.query(tableTodo);
    return List.generate(mapList.length, (index) => TodoModel.fromMap(mapList[index]));
  }

  static Future<int> deleteData(int id) async {
    final db = await open();
    return db
        .delete(tableTodo, where: '$tableColId = ?', whereArgs: [id]);
  }


}