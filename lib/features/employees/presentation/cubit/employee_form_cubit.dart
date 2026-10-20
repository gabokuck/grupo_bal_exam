import 'package:bal_exam/features/employees/domain/usecases/add_employee.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_form_state.dart';
import 'package:bal_exam/features/employees/domain/entities/employee.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeFormCubit extends Cubit<EmployeeFormState> {
  EmployeeFormCubit({required this.addEmployee})
    : super(const EmployeeFormInitial());

  final AddEmployee addEmployee;

  Future<void> submit(Employee employee) async {
    emit(const EmployeeFormSubmitting());
    try {
      await addEmployee(employee.copyWith(isActive: true));
      emit(const EmployeeFormSuccess());
    } catch (_) {
      emit(const EmployeeFormFailure('No fue posible registrar al empleado.'));
    }
  }

  void reset() => emit(const EmployeeFormInitial());
}
