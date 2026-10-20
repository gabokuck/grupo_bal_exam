import '../../presentation/entities/employee.dart';

abstract interface class EmployeRepository {
  Future<List<Employee>> getEmployees();
  Future<Employee> addEmployee(Employee employee);
  Future<Employee> toggleEmployeeStatus(String employeeId, bool isActive);
}
