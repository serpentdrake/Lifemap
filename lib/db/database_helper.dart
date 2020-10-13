import 'dart:async';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:lifemap_v7/models/user.dart';
import 'package:lifemap_v7/models/surplusCash.dart';
import 'package:lifemap_v7/models/strength.dart';
import 'package:lifemap_v7/models/weakness.dart';
import 'package:lifemap_v7/models/asset.dart';

class DBHelper {
  static Database _db;
  // User
  static const String USERID = 'userId';
  static const String FNAME = 'fName';
  static const String LNAME = 'lName';
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
  static const String STRDESC = 'strDesc';
  static const String STRTABLE = 'Strength';

  //Weakness
  static const String WEAKID = 'weakId';
  static const String WEAKDESC = 'weakDesc';
  static const String WEAKTABLE = 'Weakness';

  //Surplus Cash
  static const String CASHID = 'cashId';
  static const String CASHDESC = 'cashDesc';
  static const String CASHVAL = 'cashVal';
  static const String CASHTABLE = 'Surplus';

  //Asset Cash
  static const String ASSETID = 'assetId';
  static const String ASSETDESC = 'assetDesc';
  static const String ASSETVAL = 'assetVal';
  static const String ASSETTABLE = 'Asset';

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
    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("""
        CREATE TABLE $USERTABLE(
         $USERID INTEGER PRIMARY KEY,
         $FNAME TEXT,
         $LNAME TEXT,
         $AGE INTEGER,
         $RETIREAGE INTEGER
        )""");
    await db.execute("""
         CREATE TABLE $STRTABLE(
          $STRID INTEGER PRIMARY KEY,
          $STRDESC TEXT,
          $USERID INTEGER,
          FOREIGN KEY ($USERID)
            REFERENCES $USERTABLE($USERID)
              ON UPDATE NO ACTION 
              ON DELETE NO ACTION 
        )""");
    await db.execute("""
        CREATE TABLE $WEAKTABLE(
          $WEAKID INTERGER PRIMARY KEY,
          $WEAKDESC TEXT,
          $USERID INTEGER,
          FOREIGN KEY ($USERID)
            REFERENCES $USERTABLE($USERID)
              ON UPDATE NO ACTION
              ON UPDATE NO ACTION
        )""");
    await db.execute("""
        CREATE TABLE $CASHTABLE(
          $CASHID INTEGER PRIMARY KEY,
          $CASHDESC TEXT,
          $CASHVAL DOUBLE,
          $USERID INTEGER,
          FOREIGN KEY ($USERID)
            REFERENCES $USERTABLE($USERID)
              ON UPDATE NO ACTION
              ON UPDATE NO ACTION
        )""");
    await db.execute("""
        CREATE TABLE $ASSETTABLE(
          $ASSETID INTEGER PRIMARY KEY,
          $ASSETDESC TEXT,
          $ASSETVAL DOUBLE,
          $USERID INTEGER,
          FOREIGN KEY ($USERID)
            REFERENCES $USERTABLE($USERID)
              ON UPDATE NO ACTION
              ON UPDATE NO ACTION
        )""");
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
    List<Map> maps = await dbClient
        .query(USERTABLE, columns: [USERID, FNAME, LNAME, AGE, RETIREAGE]);
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
    return await dbClient
        .delete(USERTABLE, where: '$USERID = ?', whereArgs: [userId]);
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
    List<Map> maps = await dbClient.query(STRTABLE,
        columns: [STRID, STRDESC, USERID]);
    List<Strength> str = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        str.add(Strength.fromMap(maps[i]));
      }
    }
    return str;
  }

  Future<int> deleteStr(int strId) async {
    var dbClient = await db;
    return await dbClient
        .delete(STRTABLE, where: '$STRID = ?', whereArgs: [strId]);
  }

  Future<int> updateStr(Strength str) async {
    var dbClient = await db;
    return await dbClient.update(STRTABLE, str.toMap(),
        where: '$STRID = ?', whereArgs: [str.strId]);
  }

  Future<Strength> getRecordStr(int strId) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(STRTABLE,
        columns: [STRID, STRDESC, USERID],
        where: '$STRID = ?',
        whereArgs: [strId]);

    if (maps.length > 0) {
      return Strength.fromMap(maps.first);
    }
    return null;
  }

  //Weakness events
  Future<Weakness> saveWeak(Weakness weak) async {
    var dbClient = await db;
    weak.weakId = await dbClient.insert(WEAKTABLE, weak.toMap());
    return weak;
  }

  Future<List<Weakness>> getWeak() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(WEAKTABLE,
        columns: [WEAKID, WEAKDESC, USERID]);
//    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $USERTABLE");
    List<Weakness> weak = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        weak.add(Weakness.fromMap(maps[i]));
      }
    }
    return weak;
  }

  Future<int> deleteWeak(int weakId) async {
    var dbClient = await db;
    return await dbClient
        .delete(WEAKTABLE, where: '$WEAKID = ?', whereArgs: [weakId]);
  }

  Future<int> updateWeak(Weakness weak) async {
    var dbClient = await db;
    return await dbClient.update(WEAKTABLE, weak.toMap(),
        where: '$WEAKID = ?', whereArgs: [weak.weakId]);
  }

  //SurplusCash
  Future<Cash> saveCash(Cash cash) async {
    var dbClient = await db;
    cash.cashId = await dbClient.insert(CASHTABLE, cash.toMap());
    return cash;
  }

  Future<List<Cash>> getCash() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(CASHTABLE,
        columns: [CASHID, CASHDESC, CASHVAL, USERID]);
    List<Cash> cash = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cash.add(Cash.fromMap(maps[i]));
      }
    }
    return cash;
  }
  Future<int> updateCash(Cash cash) async {
    var dbClient = await db;
    return await dbClient.update(CASHTABLE, cash.toMap(),
        where: '$CASHID = ?', whereArgs: [cash.cashId]);
  }

  //AssetCash
  Future<Asset> saveAsset(Asset asset) async {
    var dbClient = await db;
    asset.assetId = await dbClient.insert(ASSETTABLE, asset.toMap());
    return asset;
  }

  Future<List<Asset>> getAsset() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(ASSETTABLE,
        columns: [ASSETID, ASSETDESC, ASSETVAL, USERID]);
    List<Asset> asset = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        asset.add(Asset.fromMap(maps[i]));
      }
    }
    return asset;
  }


}

