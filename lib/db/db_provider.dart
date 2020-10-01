import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../todo.dart';

class DbProvider {
  static final dbProvider = DbProvider._();
  Database _database;
  var todoTable = "todo";
  static var idColumn = "id";
  static var titleColumn = "title";
  static var bodyColumn = "body";
  static var isComplete = "is_complete";

  DbProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await _createDb();
    return _database;
  }

  Future<Database> _createDb() async {
    String path = join(await getDatabasesPath(), "todo_db.db");
    return await openDatabase(
      path, //C:\newfolder\todo_db.db
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $todoTable ( "
          "$idColumn INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$bodyColumn TEXT, "
          "$isComplete INTEGER "
          ")",
        );
      },
    );
  }

  insertTodo(Todo todo) async {
    Database db = await database;
    await db.insert(todoTable, todo.toMap());
  }

  Future<List<Todo>> getTodoList() async {
    Database db = await database;
    var result = await db.query(todoTable);
    List<Todo> todoList = List<Todo>();
    result.forEach((element) {
      Todo todo = Todo.fromMap(element);
      todoList.add(todo);
      // print(
      //   todo.id.toString() + " - " + todo.isComplete.toString(),
      // );
    });

    return todoList;
  }

  deleteTodo(int id) async {
    Database db = await database;
    await db.delete(
      todoTable,
      where: idColumn + " = ?",
      whereArgs: [id],
    );
  }
}
