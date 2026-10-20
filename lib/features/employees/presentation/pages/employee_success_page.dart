import 'package:flutter/material.dart';

import '../../../../app/routes.dart';

/// Pantalla mostrada tras registrar correctamente a un empleado.
class EmployeeSuccessPage extends StatelessWidget {
  const EmployeeSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    size: 72,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Empleado registrado correctamente',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'El registro se guardó correctamente. Puedes volver al '
                  'listado de empleados para verlo.',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: colors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => _goBack(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Regresar a empleados'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Cierra la pantalla de éxito y vuelve al listado.
  void _goBack(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushReplacementNamed(Routes.employeeList);
    }
  }
}
