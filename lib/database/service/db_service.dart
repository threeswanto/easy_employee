
import 'dart:io';

import 'package:employees_app/database/service/db_employee_service.dart';
import 'package:employees_app/database/service/db_leave_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _dbHelper;
  static Database? _database;

  DatabaseService._createObject();

  factory DatabaseService() {
    _dbHelper ??= DatabaseService._createObject();
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'db_app.db';
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    DBEmployeeService().createTableEmployee(db);
    DBLeaveService().createTableLeave(db);
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }
}
