import 'package:bal_exam/features/employees/domain/entities/employee.dart';
import 'package:equatable/equatable.dart';

sealed class EmployeeListState extends Equatable {
  const EmployeeListState();

  @override
  List<Object?> get props => [];
}

final class EmployeeInitial extends EmployeeListState {
  const EmployeeInitial();
}

final class EmployeeLoading extends EmployeeListState {
  const EmployeeLoading();
}

final class EmployeeLoaded extends EmployeeListState {
  const EmployeeLoaded(this.employees);

  final List<Employee> employees;

  @override
  List<Object?> get props => [employees];
}

final class EmployeeError extends EmployeeListState {
  const EmployeeError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
