import 'package:bal_exam/features/employees/data/datasources/employee_data_source.dart';
import 'package:bal_exam/features/employees/data/models/employee_model.dart';
import 'package:bal_exam/features/employees/domain/repositories/employee_repository.dart';
import 'package:bal_exam/features/employees/domain/entities/employee.dart';

class EmployeeRepositoryImpl implements EmployeRepository {
  const EmployeeRepositoryImpl(this._dataSource);

  final EmployeeDataSource _dataSource;

  @override
  Future<List<Employee>> getEmployees() async {
    final List<EmployeeModel> models = await _dataSource.getEmployees();
    return List<Employee>.unmodifiable(models);
  }

  @override
  Future<Employee> addEmployee(Employee employee) async {
    return _dataSource.addEmployee(EmployeeModel.fromEntity(employee));
  }

  @override
  Future<Employee> toggleEmployeeStatus(String id, bool isActive) async {
    final EmployeeModel? updated = await _dataSource.updateStatus(id, isActive);
    if (updated == null) {
      throw StateError('No existe un empleado con id "$id".');
    }
    return updated;
  }
}
