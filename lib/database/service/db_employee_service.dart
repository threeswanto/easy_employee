import 'package:employees_app/database/entity/leave_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/employee.dart';
import '../entity/employee_entity.dart';
import '../entity/table_name.dart';
import 'db_service.dart';

class DBEmployeeService {
  void createTableEmployee(Database db) async {
    await db.execute('''CREATE TABLE ${TableName.tableEmployee}(
    ${EmployeeEntity.number} INT NOT NULL,
    ${EmployeeEntity.numberId} TEXT NOT NULL,
    ${EmployeeEntity.name} TEXT NOT NULL,
    ${EmployeeEntity.address} TEXT,
    ${EmployeeEntity.dateBirth} TEXT,
    ${EmployeeEntity.joinDate} TEXT
    )''');
  }

  Future<int> insertEmployee(Employee employee) async {
    Database db = await DatabaseService().database;
    int saved = await db.insert(TableName.tableEmployee, employee.toJson());
    return saved;
  }

  Future<int> updateEmployee(Employee employee) async {
    Database db = await DatabaseService().database;
    int saved = await db.update(TableName.tableEmployee, employee.toJson(),
        where: "${EmployeeEntity.numberId} = ?",
        whereArgs: [employee.numberId]);
    return saved;
  }

  Future<int> deleteEmployee(String numberID) async {
    Database db = await DatabaseService().database;
    int saved = await db.delete(TableName.tableEmployee,
        where: "${EmployeeEntity.numberId} = ?", whereArgs: [numberID]);
    return saved;
  }

  Future<int> selectLastEmployeeNumber() async {
    int number = 0;
    Database db = await DatabaseService().database;
    var list = await db.query(TableName.tableEmployee);
    if (list.isNotEmpty) {
      Employee employee = Employee.fromJson(list.last);
      number = employee.number!;
    }
    return number + 1;
  }

  Future<List<Employee>> selectEmployee() async {
    Database db = await DatabaseService().database;
    List<Employee> listEmployee = [];
    var list = await db.query(TableName.tableEmployee);
    for (int i = 0; i < list.length; i++) {
      Employee employees = Employee.fromJson(list[i]);
      listEmployee.add(employees);
    }
    return listEmployee;
  }

  Future<List<Employee>> selectEmployeeHasLeave() async {
    Database db = await DatabaseService().database;
    List<Employee> listEmployee = [];
    var list = await db.rawQuery(
        'SELECT * from ${TableName.tableEmployee} left join ${TableName.tableLeave} using(${EmployeeEntity.numberId}) WHERE ${LeaveEntity.leaveDays} > 0');
    for (int i = 0; i < list.length; i++) {
      Employee employees = Employee.fromJson(list[i]);
      if(!listEmployee.contains(employees)) {
        listEmployee.add(employees);
      }
    }
    return listEmployee;
  }

  Future<List<Employee>> selectEmployeeHasLeaveMoreThanOne() async {
    Database db = await DatabaseService().database;
    List<Employee> listEmployee = [];
    var list = await db.rawQuery(
        'SELECT * from ${TableName.tableEmployee} left join ${TableName.tableLeave} using(${EmployeeEntity.numberId}) WHERE ${LeaveEntity.leaveDays} > 1');
    for (int i = 0; i < list.length; i++) {
      Employee employees = Employee.fromJson(list[i]);
      if(!listEmployee.contains(employees)) {
        listEmployee.add(employees);
      }
    }
    return listEmployee;
  }

  Future<List<Employee>> selectEmployeeTopThree() async {
    Database db = await DatabaseService().database;
    List<Employee> listEmployee = [];
    var list = await db.query(TableName.tableEmployee,
        orderBy: EmployeeEntity.joinDate);
    for (int i = 0; i < 3; i++) {
      Employee employees = Employee.fromJson(list[i]);
      listEmployee.add(employees);
    }
    return listEmployee;
  }

  Future<Employee> selectEmployeeByID(Employee employee) async {
    Database db = await DatabaseService().database;
    var list = await db.query(TableName.tableEmployee,
        where: "${EmployeeEntity.numberId}=?", whereArgs: [employee.numberId]);
    Employee employeeResult = Employee.fromJson(list.first);
    return employeeResult;
  }
}
