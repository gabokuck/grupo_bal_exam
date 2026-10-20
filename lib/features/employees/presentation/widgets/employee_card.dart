import 'package:bal_exam/core/utils/date_formatter.dart';
import 'package:bal_exam/features/employees/domain/entities/employee.dart';
import 'package:flutter/material.dart';

/// Tarjeta que representa a un empleado dentro de la lista.
///
/// Cuando el empleado está **Inactivo** la fila cambia visualmente mediante
/// una combinación de fondo gris, opacidad, texto tachado/cursiva y un chip
/// de estado gris, frente a la apariencia normal del empleado **Activo**.
class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onStatusChanged,
  });

  final Employee employee;
  final ValueChanged<bool> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final bool isActive = employee.isActive;
    final ColorScheme colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isActive ? colors.surface : colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? colors.primary.withValues(alpha: 0.25)
              : colors.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Avatar(employee: employee, isActive: isActive),
            const SizedBox(width: 14),
            Expanded(
              child: _EmployeeInfo(employee: employee, isActive: isActive),
            ),
            Semantics(
              label: isActive
                  ? 'Desactivar a ${employee.fullName}'
                  : 'Activar a ${employee.fullName}',
              child: Switch(
                value: isActive,
                onChanged: (bool value) => onStatusChanged(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.employee, required this.isActive});

  final Employee employee;
  final bool isActive;

  String get _initials {
    final List<String> parts = employee.fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((String p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Opacity(
      opacity: isActive ? 1 : 0.5,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: isActive
            ? colors.primaryContainer
            : colors.surfaceContainerHighest,
        child: Text(
          _initials,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isActive
                ? colors.onPrimaryContainer
                : colors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _EmployeeInfo extends StatelessWidget {
  const _EmployeeInfo({required this.employee, required this.isActive});

  final Employee employee;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colors = Theme.of(context).colorScheme;

    final TextStyle nameStyle = textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w600,
      decoration: isActive ? TextDecoration.none : TextDecoration.lineThrough,
      fontStyle: isActive ? FontStyle.normal : FontStyle.italic,
      color: isActive ? colors.onSurface : colors.onSurfaceVariant,
    );

    final TextStyle detailStyle = textTheme.bodySmall!.copyWith(
      color: colors.onSurfaceVariant,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(employee.fullName, style: nameStyle),
        const SizedBox(height: 6),
        Opacity(
          opacity: isActive ? 1 : 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailLine(
                icon: Icons.work_outline,
                text: '${employee.jobPosition} · ${employee.area}',
                style: detailStyle,
              ),
              _DetailLine(
                icon: Icons.wc_outlined,
                text: employee.gender,
                style: detailStyle,
              ),
              _DetailLine(
                icon: Icons.event_available_outlined,
                text: 'Entrada: ${DateFormatter.format(employee.hireDate)}',
                style: detailStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _StatusChip(isActive: isActive),
      ],
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine({
    required this.icon,
    required this.text,
    required this.style,
  });

  final IconData icon;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 14, color: style.color),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: style)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Color background = isActive
        ? Colors.green.withValues(alpha: 0.15)
        : colors.surfaceContainerHighest;
    final Color foreground = isActive
        ? Colors.green.shade700
        : colors.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.pause_circle_filled,
            size: 14,
            color: foreground,
          ),
          const SizedBox(width: 5),
          Text(
            isActive ? 'Activo' : 'Inactivo',
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
