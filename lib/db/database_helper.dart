import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/models/time.dart';
import 'package:lifemap_v7/models/strength.dart';

class DBHelper {
  static Database _db;
  // User
  static const String USERID = 'userId';
  static const String FNAME = 'fName';
  static const String LNAME = 'lName';
  static const String BIRTHDATE = 'birthDate';
  static const String AGE = 'age';
  static const String RETIREAGE = 'retireAge';
  static const String USERTABLE = 'User';

  //Time
  static const String TIMEID = 'timeId';
  static const String PRODYEAR = 'prodYear';
  static const String PRODHOUR = 'prodHour';
  static const String TIMETABLE = 'Time';

  //Strength
  static const String STRID = 'strId';
  static const String STR1 = 'str1';
  static const String STR2 = 'str2';
  static const String STR3 = 'str3';
  static const String STR4 = 'str4';
  static const String STR5 = 'str5';
  static const String STRTABLE = 'Strength';


  //database
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
           $BIRTHDATE DATE,
           $AGE INTEGER,
           $RETIREAGE INTEGER
          )"""
        );
    await db
        .execute("""
           CREATE TABLE $STRTABLE(
            $STRID INTEGER PRIMARY KEY,
            $STR1 TEXT, 
            $STR2 TEXT, 
            $STR3 TEXT, 
            $STR4 TEXT, 
            $STR5 TEXT,
            $USERID INTEGER,
            FOREIGN KEY ($USERID)
              REFERENCES $USERTABLE($USERID)
                ON UPDATE NO ACTION 
                ON DELETE NO ACTION 
          )"""
        );
    // await db
    //     .execute(""""
    //       CREATE TABLE $TIMETABLE(
    //        $TIMEID INTEGER PRIMARY KEY,
    //        $PRODHOUR INTEGER,
    //        $PRODYEAR INTEGER
    //        $USERID INTEGER,
    //        FOREIGN KEY ($USERID)
    //         REFERENCES $USERTABLE ($USERID)
    //           ON UPDATE NO ACTION
    //           ON DELETE NO ACTION
    //       )"""
    //     );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }



  //User events
  Future<User> saveUser(User user) async {
    var dbClient = await db;
    user.userId = await dbClient.insert(USERTABLE, user.toMap());
    return user;
  }

  Future<List<User>> getUser() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(USERTABLE, columns: [USERID, FNAME, LNAME,  BIRTHDATE, AGE, RETIREAGE]);
//    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $USERTABLE");
    List<User> user = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        user.add(User.fromMap(maps[i]));
      }
    }
    return user;
  }

  Future<int> deleteUser(int userId) async {
    var dbClient = await db;
    return await dbClient.delete(USERTABLE, where: '$USERID = ?', whereArgs: [userId]);
  }

  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(USERTABLE, user.toMap(),
        where: '$USERID = ?', whereArgs: [user.userId]);
  }

  //Strength
  Future<Strength> saveStr(Strength str) async {
    var dbClient = await db;
    str.strId = await dbClient.insert(STRTABLE, str.toMap());
    return str;
  }

  Future<List<Strength>> getStr() async {
    var dbClient = await db;
    List<Map>  maps = await dbClient.query(STRTABLE, columns: [STRID, STR1, STR2, STR3, STR4, STR5, USERID]);
    List<Strength> str = [];
    if(maps.length > 0) {
      for(int i = 0; i < maps.length; i++) {
        str.add(Strength.fromMap(maps[i]));
      }
    }
    return str;
  }

  Future<int> deleteStr(int strId) async {
    var dbClient = await db;
    return await dbClient.delete(STRTABLE, where: '$STRID = ?', whereArgs: [strId]);
  }


  //Time events
  Future<Time> saveTime(Time time) async {
    var dbClient = await db;
    time.timeId = await dbClient.insert(TIMETABLE, time.toMap());
    return time;
  }

  Future<List<Time>> getTime() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TIMETABLE, columns: [TIMEID, PRODHOUR, PRODYEAR]);
//    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $USERTABLE");
    List<Time> time = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        time.add(Time.fromMap(maps[i]));
      }
    }
    return time;
  }

  Future<int> deleteTime(int timeId) async {
    var dbClient = await db;
    return await dbClient.delete(TIMETABLE, where: '$TIMEID = ?', whereArgs: [timeId]);
  }

}