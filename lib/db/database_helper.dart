import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:lifemap_v7/models/user.dart';

class DBHelper {
  static Database _db;
  // User
  static const String USERID = 'userId';
  static const String FNAME = 'fName';
  static const String LNAME = 'lName';
  static const String DATE = 'date';
  static const String RETIREAGE = 'retireAge';
  static const String USERTABLE = 'User';


  //datambase
  static const String DB_NAME = 'lifemap.db';


  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  _onCreate (Database db, int version) async {
    await db
        .execute("""
          CREATE TABLE $USERTABLE(
           $USERID INTEGER PRIMARY KEY,
           $FNAME TEXT,
           $LNAME TEXT,
           $DATE DATE,
           $RETIREAGE INTEGER
          )"""
        );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  //User events
  Future<User> saveUser(User user) async {
    var dbClient = await db;
    user.id = await dbClient.insert(USERTABLE, user.toMap());
    return user;
  }

  Future<List<User>> getUser() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(USERTABLE, columns: [USERID, FNAME, LNAME,  DATE, RETIREAGE]);
//    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $USERTABLE");
    List<User> user = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user.add(User.fromMap(maps[i]));
      }
    }
    return user;
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete(USERTABLE, where: '$USERID = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(USERTABLE, user.toMap(),
        where: '$USERID = ?', whereArgs: [user.id]);
  }


}