import 'package:bal_exam/features/employees/domain/repositories/employee_repository.dart';
import 'package:bal_exam/features/employees/presentation/entities/employee.dart';

class AddEmployee {
  const AddEmployee(this._repository);
  final EmployeRepository _repository;
  Future<Employee> call(Employee employee) async {
    return await _repository.addEmployee(employee);
  }
}
