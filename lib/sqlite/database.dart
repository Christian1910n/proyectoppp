import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "db_login.db";
  static final _databaseVersion = 1;

  static final table = 'login';
  static final columnId = '_id';
  static final columnName = 'email';
  static final columnPassword = 'password';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, _databaseName);
    return await openDatabase(fullPath,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnPassword TEXT NOT NULL
      )
    ''');
    print('TABLA CREADA');
  }

  Future<int> insertOrUpdateCredentials(String name, String password) async {
    Database db = await instance.database;
    List<Map> result = await db.query(table,
        columns: [columnId], where: '$columnName = ?', whereArgs: [name]);
    if (result.isNotEmpty) {
      int id = result.first[columnId];
      return await db.update(
          table, {columnName: name, columnPassword: password},
          where: '$columnId = ?', whereArgs: [id]);
    } else {
      return await db
          .insert(table, {columnName: name, columnPassword: password});
    }
  }

  Future<Map?> getCredentials(String name) async {
    Database db = await instance.database;
    List<Map> result = await db.query(table,
        columns: [columnName, columnPassword],
        where: '$columnName = ?',
        whereArgs: [name]);
    if (result.isNotEmpty) {
      print(result.first);
      return result.first;
    } else {
      print('vacio');
      return null;
    }
  }
}
