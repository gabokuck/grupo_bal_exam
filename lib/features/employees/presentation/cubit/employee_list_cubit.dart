import 'package:bal_exam/features/employees/domain/usecases/get_employees.dart';
import 'package:bal_exam/features/employees/domain/usecases/toggle_employee_status.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_list_state.dart';
import 'package:bal_exam/features/employees/domain/entities/employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit({required this.getEmployees, required this.toggleStatus})
    : super(const EmployeeInitial());

  final GetEmployees getEmployees;
  final ToggleEmpleyeeStatus toggleStatus;

  Future<void> loadEmployees() async {
    emit(const EmployeeLoading());
    try {
      final List<Employee> employees = await getEmployees();
      emit(EmployeeLoaded(employees));
    } catch (_) {
      emit(const EmployeeError('No fue posible cargar los empleados.'));
    }
  }

  Future<void> toggleEmployeeStatus(String id, bool isActive) async {
    try {
      final Employee updated = await toggleStatus(id, isActive);
      final EmployeeListState current = state;
      if (current is! EmployeeLoaded) return;

      emit(
        EmployeeLoaded([
          for (final Employee employee in current.employees)
            if (employee.id == updated.id) updated else employee,
        ]),
      );
    } catch (_) {
      emit(const EmployeeError('No fue posible actualizar el estado.'));
    }
  }
}
