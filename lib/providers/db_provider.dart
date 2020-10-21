import 'dart:io';
import 'package:lifemap_betav1/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'lifemap.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE User('
              'id INTEGER PRIMARY KEY,'
              'fName TEXT,'
              'lName TEXT,'
              'age INTEGER,'
              'retireAge INTEGER,'
              'monthIn DOUBLE'
              ')');
        });
  }

  // Insert employee on database
  Future<User> createUser(User user) async {
    // await deleteAllUser();
    final db = await database;
    user.id = await db.insert('User', user.toJson());

    return user;
  }

  Future<int> deleteAllUser() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM User');

    return res;
  }

  Future<List<User>> getAllUser() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM USER");

    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];

    return list;
  }

//   Future<int> queryVegetarianCount() async {
//     var vegList = await queryVegetarian();
//     int count = vegList.length;
//     return count;
//   }
//
//   Future<double> queryOmnivoreCount() async {
//     var omniList = await queryOmnivore();
//     int omniCount = omniList.length;
//     return omniCount.toDouble();
//   }
//
//   Future<double> calcOmnivorePercentage() async {
//     var x = await queryOmnivoreCount();
//     var y = await queryRowCount();
//     double omniPercentage = (x / y) * 100;
//     return omniPercentage;
//   }
// }


}