import 'package:next/helpers/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    //initialize
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;
  // Check if database exists or not
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  // Inserting data to Table
  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  // Read data from table
  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }
}
