import 'package:equatable/equatable.dart';

sealed class EmployeeFormState extends Equatable {
  const EmployeeFormState();

  @override
  List<Object?> get props => [];
}

final class EmployeeFormInitial extends EmployeeFormState {
  const EmployeeFormInitial();
}

final class EmployeeFormSubmitting extends EmployeeFormState {
  const EmployeeFormSubmitting();
}

final class EmployeeFormSuccess extends EmployeeFormState {
  const EmployeeFormSuccess();
}

final class EmployeeFormFailure extends EmployeeFormState {
  const EmployeeFormFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
