import 'package:employees_app/database/service/db_employee_service.dart';
import 'package:employees_app/database/utils/value_utils.dart';
import 'package:employees_app/model/employee.dart';
import 'package:employees_app/view/screen/employee/employee_detail/employee_detail_notifier.dart';
import 'package:employees_app/view/screen/employee/employee_list/employee_list_notifier.dart';
import 'package:employees_app/view/snackbar/snackbar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class EmployeeFormNotifier extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _controllerBirthDate = TextEditingController();

  TextEditingController get controllerBirthDate => _controllerBirthDate;

  final TextEditingController _controllerJoinDate = TextEditingController();

  TextEditingController get controllerJoinDate => _controllerJoinDate;

  final TextEditingController _name = TextEditingController();

  TextEditingController get name => _name;

  final TextEditingController _address = TextEditingController();

  TextEditingController get address => _address;

  int? _number;

  int? get number => _number;

  String? _numberID;

  String? get numberID => _numberID;

  String? _birthDate;

  String? get birthDate => _birthDate;

  String? _joinDate;

  String? get joinDate => _joinDate;

  bool _isEdit = false;

  bool get isEdit => _isEdit;

  onInitForm(Employee? employee) {
    if (employee != null) {
      _numberID = employee.numberId;
      _number = employee.number;
      _name.text = employee.name!;
      _address.text = employee.address!;
      _controllerJoinDate.text = employee.joinDate!;
      _controllerBirthDate.text = employee.birthDate!;
      _isEdit = true;
    } else {
      generateID();
    }
  }

  generateID() async {
    int lastNumber = await DBEmployeeService().selectLastEmployeeNumber();
    _number = lastNumber;
    _numberID = ValueUtils.generateID(lastNumber);
    notifyListeners();
  }

  onChangeBirthDate(String value) {
    _birthDate = value;
    notifyListeners();
  }

  onChangeJoinDate(String value) {
    _joinDate = value;
    notifyListeners();
  }

  onSavedEmployee(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Employee employee = Employee();
      employee.number = _number;
      employee.numberId = _numberID;
      employee.name = _name.text;
      employee.joinDate = _controllerJoinDate.text;
      employee.birthDate = _controllerBirthDate.text;
      employee.address = _address.text;
      if (_isEdit) {
        int saved = await DBEmployeeService().updateEmployee(employee);
        if (saved > 0) {
          context.read<EmployeeListNotifier>().onInitScreen();
          context.read<EmployeeDetailNotifier>().onInitDetail(employee);
          Navigator.pop(context);
          SnackBarService.showSuccessSnackBar(context, "Employee is saved");
        } else {
          SnackBarService.showWarningSnackBar(context, "Employee is not saved");
        }
      } else {
        int saved = await DBEmployeeService().insertEmployee(employee);
        if (saved > 0) {
          context.read<EmployeeListNotifier>().onInitScreen();
          context.read<EmployeeDetailNotifier>().onInitDetail(employee);
          Navigator.pop(context);
          SnackBarService.showSuccessSnackBar(context, "Employee is saved");
        } else {
          SnackBarService.showWarningSnackBar(context, "Employee is not saved");
        }
      }
    }
  }
}
