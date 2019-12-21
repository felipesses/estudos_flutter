import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planets_app/model/Planet.dart';

class DB {
  static final DB _instance = new DB.internal();
  factory DB() => _instance;

  DB.internal();

  final String planetTable = "planetTable";
  final String id = "id";
  final String name = "name";
  final String description = "description";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mainDB.db");
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $planetTable($id int primary key,"
        "$name varchar(100) not null,"
        "$description varchar (900) not null)");
  }

  Future<int> insertPlanet(Planet planet) async {
    var dbPlanet = await db;
    int res = await dbPlanet.insert("$planetTable", planet.toMap());
    return res;
  }

  Future<List> getPlanets() async {
    var dbPlanet = await db;
    var res = await dbPlanet.rawQuery("select * from $planetTable");
    return res.toList();
  }

  Future<int> getCount() async {
    var dbPlanet = await db;
    return Sqflite.firstIntValue(
        await dbPlanet.rawQuery("select count (*) from $planetTable"));
  }

  Future<Planet> getPlanet(int id) async {
    var dbPlanet = await db;
    var res = await dbPlanet.rawQuery("select * from $planetTable"
        " where $id = $id");

    if (res.length == 0) return null;
  }

  Future<int> deletePlanet(int id) async {
    var dbPlanet = await db;
    return await dbPlanet
        .delete(planetTable, where: "$id = ?", whereArgs: [id]);
  }

  Future close() async {
    var dbPlanet = await db;
    return dbPlanet.close();
  }
}
