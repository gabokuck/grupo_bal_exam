import 'package:bal_exam/features/employees/domain/repositories/employee_repository.dart';
import 'package:bal_exam/features/employees/domain/entities/employee.dart';

class GetEmployees {
  final EmployeRepository _repository;

  GetEmployees(this._repository);

  Future<List<Employee>> call() async {
    return await _repository.getEmployees();
  }
}
