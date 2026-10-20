import 'package:bal_exam/app/routes.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_list_cubit.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_list_state.dart';
import 'package:bal_exam/features/employees/presentation/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla principal: lista de empleados registrados.
class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListCubit, EmployeeListState>(
      builder: (BuildContext context, EmployeeListState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Empleados'), centerTitle: false),
          body: _body(context, state),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openForm(context),
            icon: const Icon(Icons.person_add_alt),
            label: const Text('Agregar empleado'),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, EmployeeListState state) {
    return switch (state) {
      EmployeeInitial() ||
      EmployeeLoading() => const Center(child: CircularProgressIndicator()),
      EmployeeError(:final message) => _ErrorView(
        message: message,
        onRetry: () => context.read<EmployeeListCubit>().loadEmployees(),
      ),
      EmployeeLoaded(:final employees) =>
        employees.isEmpty
            ? const _EmptyView()
            : RefreshIndicator(
                onRefresh: () =>
                    context.read<EmployeeListCubit>().loadEmployees(),
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                  itemCount: employees.length,
                  itemBuilder: (BuildContext context, int index) {
                    final employee = employees[index];
                    return EmployeeCard(
                      key: ValueKey<String>('employee-${employee.id}'),
                      employee: employee,
                      onStatusChanged: (bool value) {
                        context.read<EmployeeListCubit>().toggleEmployeeStatus(
                          employee.id,
                          value,
                        );
                      },
                    );
                  },
                ),
              ),
    };
  }

  /// Abre el formulario y, al regresar, recarga la lista para que el empleado
  /// recién registrado aparezca en pantalla.
  Future<void> _openForm(BuildContext context) async {
    final NavigatorState navigator = Navigator.of(context);
    final EmployeeListCubit cubit = context.read<EmployeeListCubit>();

    await navigator.pushNamed(Routes.employeeForm);
    await cubit.loadEmployees();
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.groups_outlined, size: 72, color: colors.outline),
            const SizedBox(height: 16),
            Text(
              'Aún no hay empleados registrados',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Usa el botón "Agregar empleado" para registrar el primero.',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: colors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
