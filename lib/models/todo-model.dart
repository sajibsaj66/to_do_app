const String tableTodo = 'tbl_todo';
const String tableColId = 'id';
const String tableColTaskName= 'taskName';
const String tableColTaskTime = 'taskTime';
const String tableColDeadLine = 'deadLine';


class TodoModel{
  int? id;
  String? taskName;
  String? taskTime;
  String? deadLine;

  TodoModel({this.id, this.taskName, this.taskTime, this.deadLine});

  Map<String,dynamic> toMap(){
    var map = <String,dynamic> {
      tableColTaskName : taskName,
      tableColTaskTime : taskTime,
      tableColDeadLine : deadLine
    };
    if(id!=null){
      map[tableColId]=id;
    }
    return map;
  }

  factory TodoModel.fromMap(Map<String,dynamic> map)=>TodoModel(
    taskName: map[tableColTaskName],
    taskTime: map[tableColTaskTime],
    deadLine: map[tableColDeadLine],
  );

}