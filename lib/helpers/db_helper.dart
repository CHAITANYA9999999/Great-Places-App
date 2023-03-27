import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> database() async {
    //*It will create a new database and its path will be outputed
    final dbPath = await sql.getDatabasesPath();

    //*Not it will open the database, if it doesn't find the file, it will
    //*create a database
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: ((db, version) {
      return db.execute(
          //If you remember, it is a sql command
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }), version: 1);
  }

  //*Static method means that we can use this method without even instantiating
  //* the class
  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDB = await DBHelper.database();

    await sqlDB.insert(
      table,
      data,
      //*If we are trying to insert data for an ID which already is in the database
      //*table, then we will override the existing entry with the new data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final sqlDB = await DBHelper.database();
    return sqlDB.query(table);
  }
}
