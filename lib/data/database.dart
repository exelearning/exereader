import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/**
 * DatabaseHelper
 *
 * Manage the app database.
 *
 * Reference: https://suragch.medium.com/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
 * Adapted by Samuel Soto
 */

class DatabaseHelper {
  static final _databaseName = "MyProjects.db";
  static final _databaseVersion = 3;
  static final table = 'projects';

  //Name is a ID because is more easy search, delete the projects and skip duplicities.
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDescription = 'description';
  static final columnAuthor = 'author';
  static final columnPath = 'path';
  static final columnLicense = 'license';
  static final columnPortada = 'portada';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //Only have a single app-wide reference to the database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  //Open the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnAuthor TEXT NOT NULL,
            $columnPath TEXT NOT NULL,
            $columnLicense TEXT,
            $columnPortada TEXT
          )
          ''');
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade de $oldVersion a $newVersion");

    if (oldVersion < newVersion) {
      if (oldVersion == 1) {
        print("oldVersion == 1");
        db.execute("ALTER TABLE $table ADD COLUMN $columnLicense TEXT;");
        db.execute("UPDATE $table set path = SUBSTR(path, INSTR(path, \"/projects\"))");
        oldVersion = 2;
      }

      if (oldVersion == 2) {
        print("oldVersion == 2");
        db.execute("ALTER TABLE $table ADD COLUMN $columnPortada TEXT;");
        //oldVersion = 3;
      }

      //db.execute("ALTER TABLE tb_name ADD COLUMN newCol TEXT;");
    }
  }

  //Helper methods

  /**
   * insert
   *
   * Inserts a row in the database where each key in the Map is a column name
   * and the value is the column value. The return value is the id of the
   * inserted row.
   */
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  /**
   * queryAllRows
   *
   * All of the rows are returned as a list of maps, where each map is
   * a key-value list of columns.
   */
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  /**
   * queryRowCount
   *
   * All of the methods (insert, query, update, delete) can also be done using
   * raw SQL commands. This method uses a raw query to give the row count.
   */
  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  /**
   * getProjectById
   *
   *
   */
  Future<List<Map<String, dynamic>>> getProjectById(int id) async {
    Database? db = await instance.database;
    return await db!.rawQuery('SELECT * FROM $table where _id = $id');
  }

  /**
   * update
   *
   * We are assuming here that the id column in the map is set. The other
   * column values will be used to update the row.
   */
  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  /**
   * delete
   *
   * Deletes the row specified by the id. The number of affected rows is
   * returned. This should be 1 as long as the row exists.
   */
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
