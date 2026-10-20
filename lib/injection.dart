import 'package:bal_exam/features/employees/data/datasources/employee_data_source.dart';
import 'package:bal_exam/features/employees/data/repositories/employee_repository_impl.dart';
import 'package:bal_exam/features/employees/domain/repositories/employee_repository.dart';
import 'package:bal_exam/features/employees/domain/usecases/add_employee.dart';
import 'package:bal_exam/features/employees/domain/usecases/get_employees.dart';
import 'package:bal_exam/features/employees/domain/usecases/toggle_employee_status.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void configureDependencies() {
  // Capa de datos
  sl.registerLazySingleton<EmployeeDataSource>(MockEmployeeDataSource.new);
  sl.registerLazySingleton<EmployeRepository>(
    () => EmployeeRepositoryImpl(sl<EmployeeDataSource>()),
  );

  // Casos de uso. El tipo se indica explícitamente porque las clases de caso
  // de uso son invocables (definen `call()`); sin el argumento de tipo, Dart
  // inferiría `Function` en lugar de la clase concreta.
  sl.registerLazySingleton<GetEmployees>(
    () => GetEmployees(sl<EmployeRepository>()),
  );
  sl.registerLazySingleton<AddEmployee>(
    () => AddEmployee(sl<EmployeRepository>()),
  );
  sl.registerLazySingleton<ToggleEmpleyeeStatus>(
    () => ToggleEmpleyeeStatus(sl<EmployeRepository>()),
  );
}
