import 'package:bal_exam/features/employees/domain/repositories/employee_repository.dart';
import 'package:bal_exam/features/employees/presentation/entities/employee.dart';

class ToggleEmpleyeeStatus {
  const ToggleEmpleyeeStatus(this._repository);
  final EmployeRepository _repository;
  Future<Employee> call(String employeeId, bool isActive) async {
    return await _repository.toggleEmployeeStatus(employeeId, isActive);
  }
}
