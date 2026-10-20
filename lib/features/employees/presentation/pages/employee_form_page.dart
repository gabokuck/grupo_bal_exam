import 'package:bal_exam/app/routes.dart';
import 'package:bal_exam/core/constants/areas.dart';
import 'package:bal_exam/core/constants/genders.dart';
import 'package:bal_exam/core/utils/date_formatter.dart';
import 'package:bal_exam/features/employees/domain/entities/employee.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_form_cubit.dart';
import 'package:bal_exam/features/employees/presentation/cubit/employee_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla de registro de empleado.
class EmployeeFormPage extends StatefulWidget {
  const EmployeeFormPage({super.key});

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<DateTime>> _hireDateKey =
      GlobalKey<FormFieldState<DateTime>>();
  final GlobalKey<FormFieldState<DateTime>> _birthDateKey =
      GlobalKey<FormFieldState<DateTime>>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _jobPositionController = TextEditingController();

  String? _area;
  String? _gender;
  DateTime? _hireDate;
  DateTime? _birthDate;

  @override
  void dispose() {
    _fullNameController.dispose();
    _jobPositionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeFormCubit, EmployeeFormState>(
      listener: _onFormStateChanged,
      child: Scaffold(
        appBar: AppBar(title: const Text('Nuevo empleado')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo *',
                      hintText: 'Ej. Juan Carlos Pérez',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: _requiredValidator(
                      'El nombre completo es obligatorio',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _area,
                    decoration: const InputDecoration(
                      labelText: 'Área',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.apartment_outlined),
                    ),
                    items: [
                      for (final String area in Areas.areas)
                        DropdownMenuItem<String>(
                          value: area,
                          child: Text(area),
                        ),
                    ],
                    onChanged: (String? value) => setState(() => _area = value),
                    validator: _requiredValidator('Selecciona un área'),
                  ),
                  const SizedBox(height: 16),
                  _DateField(
                    fieldKey: _hireDateKey,
                    widgetKey: const ValueKey<String>('field-hire-date'),
                    label: 'Fecha de entrada',
                    value: _hireDate,
                    icon: Icons.event_available_outlined,
                    firstDate: DateTime(1990),
                    lastDate: DateTime.now(),
                    onChanged: (DateTime? date) =>
                        setState(() => _hireDate = date),
                    validationMessage: 'Selecciona la fecha de entrada',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _jobPositionController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Puesto del empleado *',
                      hintText: 'Ej. Analista de Datos',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: _requiredValidator(
                      'El puesto del empleado es obligatorio',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: _gender,
                    decoration: const InputDecoration(
                      labelText: 'Género',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.wc_outlined),
                    ),
                    items: [
                      for (final String gender in Genders.genders)
                        DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ),
                    ],
                    onChanged: (String? value) =>
                        setState(() => _gender = value),
                    validator: _requiredValidator('Selecciona un género'),
                  ),
                  const SizedBox(height: 16),
                  _DateField(
                    fieldKey: _birthDateKey,
                    widgetKey: const ValueKey<String>('field-birth-date'),
                    label: 'Fecha de nacimiento',
                    value: _birthDate,
                    icon: Icons.cake_outlined,
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now(),
                    onChanged: (DateTime? date) =>
                        setState(() => _birthDate = date),
                    validationMessage: 'Selecciona la fecha de nacimiento',
                  ),
                  const SizedBox(height: 28),
                  BlocBuilder<EmployeeFormCubit, EmployeeFormState>(
                    builder: (BuildContext context, EmployeeFormState state) {
                      final bool submitting = state is EmployeeFormSubmitting;
                      return FilledButton(
                        onPressed: submitting ? null : _submit,
                        child: submitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Registrar'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormStateChanged(BuildContext context, EmployeeFormState state) {
    if (state is EmployeeFormSuccess) {
      context.read<EmployeeFormCubit>().reset();
      // Se reemplaza la ruta del formulario por la de éxito: así el botón
      // "Regresar a empleados" vuelve directamente al listado.
      Navigator.of(context).pushReplacementNamed(Routes.employeeSuccess);
    } else if (state is EmployeeFormFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(state.message)));
      context.read<EmployeeFormCubit>().reset();
    }
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<EmployeeFormCubit>().submit(
      Employee(
        // El id se deja vacío a propósito: lo asigna la fuente de datos al
        // persistir, de modo que la UI no inventa identificadores.
        id: '',
        fullName: _fullNameController.text.trim(),
        area: _area!,
        jobPosition: _jobPositionController.text.trim(),
        gender: _gender!,
        birthDate: _birthDate!,
        hireDate: _hireDate!,
        isActive: true,
      ),
    );
  }

  String? Function(String?) _requiredValidator(String message) {
    return (String? value) =>
        (value == null || value.trim().isEmpty) ? message : null;
  }
}

/// Campo de solo lectura que abre un [showDatePicker].
///
/// El usuario nunca escribe la fecha manualmente: la selección se propaga al
/// [FormFieldState] mediante `didChange` para que la validación del formulario
/// se mantenga sincronizada.
class _DateField extends StatelessWidget {
  const _DateField({
    required this.fieldKey,
    required this.widgetKey,
    required this.label,
    required this.value,
    required this.icon,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    required this.validationMessage,
  });

  final GlobalKey<FormFieldState<DateTime>> fieldKey;
  final Key widgetKey;
  final String label;
  final DateTime? value;
  final IconData icon;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<DateTime?> onChanged;
  final String validationMessage;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initial = value ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(firstDate)
          ? firstDate
          : initial.isAfter(lastDate)
          ? lastDate
          : initial,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: 'Selecciona $label',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );

    if (picked != null) {
      fieldKey.currentState?.didChange(picked);
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      key: fieldKey,
      initialValue: value,
      validator: (DateTime? date) => date == null ? validationMessage : null,
      builder: (FormFieldState<DateTime> field) {
        final bool hasError = field.hasError;
        return InkWell(
          key: widgetKey,
          onTap: () => _pickDate(context),
          borderRadius: BorderRadius.circular(4),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon),
              border: const OutlineInputBorder(),
              errorText: hasError ? field.errorText : null,
              suffixIcon: const Icon(Icons.calendar_month_outlined),
            ),
            child: Text(
              value == null
                  ? 'Seleccionar fecha'
                  : DateFormatter.format(value!),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: value == null
                    ? Theme.of(context).hintColor
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}
