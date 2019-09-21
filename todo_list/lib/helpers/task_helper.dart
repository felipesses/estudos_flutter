import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task.dart';

class TaskHelper {
  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database _db;

  //////////// PERSISTENCIA /////////////////

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }



  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "todo_list.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE task("
          "id INTEGER PRIMARY KEY, "
          "title TEXT, "
          "description TEXT, "
          "isDone INTEGER)");
    });
  }

  Future<int> getCount() async {
    Database database = await db;
    return Sqflite.firstIntValue(
        await database.rawQuery("SELECT COUNT(*) FROM task"));
  }

  Future close() async {
    Database database = await db;
    database.close();
  }

  // inserir dados

  Future<Task> save(Task task) async {
    Database database = await db;
    task.id = await database.insert('task', task.toMap());
    return task;
  }

  //read por id

  Future<Task> getById(int id) async {
    Database database = await db;
    List<Map> maps = await database.query('task',
        columns: ['id', 'title', 'description', 'isDone'],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //delete

  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database database = await db;
    return await database.rawDelete("DELETE * from task");
  }

  // atualizar

  Future<int> update(Task task) async {
    Database database = await db;
    return await database
        .update('task', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // ler todas as tarefas

  Future<List<Task>> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM task");
    List<Task> stuffList = listMap.map((x) => Task.fromMap(x)).toList();
    return stuffList;
  }
}
