import 'package:bal_exam/features/employees/domain/usecases/toggle_employee_status.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_form_cubit.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_list_cubit.dart';
import 'package:bal_exam/features/employees/presentation/pages/employee_form_page.dart';
import 'package:bal_exam/features/employees/presentation/pages/employee_list_page.dart';
import 'package:bal_exam/features/employees/presentation/pages/employee_success_page.dart';
import 'package:bal_exam/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/employees/domain/usecases/add_employee.dart';
import '../features/employees/domain/usecases/get_employees.dart';

import 'routes.dart';
import 'theme.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeListCubit>(
          create: (_) => EmployeeListCubit(
            getEmployees: sl<GetEmployees>(),
            toggleStatus: sl<ToggleEmpleyeeStatus>(),
          )..loadEmployees(),
        ),
        BlocProvider<EmployeeFormCubit>(
          create: (_) => EmployeeFormCubit(addEmployee: sl<AddEmployee>()),
        ),
      ],
      child: MaterialApp(
        title: 'Gestión de Empleados',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        initialRoute: Routes.employeeList,
        routes: {
          Routes.employeeList: (_) => const EmployeeListPage(),
          Routes.employeeForm: (_) => const EmployeeFormPage(),
          Routes.employeeSuccess: (_) => const EmployeeSuccessPage(),
        },
      ),
    );
  }
}
