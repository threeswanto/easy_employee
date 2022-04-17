import 'package:employees_app/database/entity/employee_entity.dart';
import 'package:employees_app/database/entity/leave_entity.dart';
import 'package:employees_app/database/entity/table_name.dart';
import 'package:employees_app/database/service/db_service.dart';
import 'package:employees_app/model/leave.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/employee.dart';

class DBLeaveService {

  void createTableLeave(Database db) async {
    await db.execute('''CREATE TABLE ${TableName.tableLeave}(
    ${LeaveEntity.numberId} TEXT NOT NULL,
    ${LeaveEntity.leaveDate} TEXT NOT NULL,
    ${LeaveEntity.leaveDays} INT,
    ${LeaveEntity.note} TEXT
    )''');
  }

  Future<int> insertLeave(Leave leave) async {
    Database db = await DatabaseService().database;
    int saved = await db.insert(TableName.tableLeave, leave.toJson());
    return saved;
  }

  Future<int> deleteLeave(String numberID) async {
    Database db = await DatabaseService().database;
    int saved = await db.delete(TableName.tableLeave, where: "${LeaveEntity.numberId} = ?", whereArgs: [numberID]);
    return saved;
  }

  Future<List<Leave>> selectLeaveByEmployee(Employee employee) async {
    Database db = await DatabaseService().database;
    List<Leave> listLeave = [];
    var list = await db.query(TableName.tableLeave, where: "${EmployeeEntity.numberId}=?", whereArgs: [employee.numberId]);
    for(int i=0; i < list.length; i++) {
      Leave leave = Leave.fromJson(list[i]);
      listLeave.add(leave);
    }
    return listLeave;
  }
}