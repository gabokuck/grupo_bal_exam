import 'package:bal_exam/features/employees/data/models/employee_model.dart';

abstract interface class EmployeeDataSource {
  Future<List<EmployeeModel>> getEmployees();
  Future<EmployeeModel> addEmployee(EmployeeModel employee);
  Future<EmployeeModel?> updateStatus(String id, bool isActive);
}

class MockEmployeeDataSource implements EmployeeDataSource {
  MockEmployeeDataSource() : _employees = List<EmployeeModel>.of(_seed);

  /// Latencia simulada para que los estados de carga sean observables.
  static const Duration _latency = Duration(milliseconds: 300);

  static int _sequence = 100;
  List<EmployeeModel> _employees;

  static final List<EmployeeModel> _seed = <EmployeeModel>[
    EmployeeModel(
      id: '1',
      fullName: 'María Fernanda Gómez',
      area: 'Tecnología',
      jobPosition: 'Ingeniera de Software Senior',
      gender: 'Femenino',
      birthDate: DateTime(1990, 4, 12),
      hireDate: DateTime(2019, 2, 1),
      isActive: true,
    ),
    EmployeeModel(
      id: '2',
      fullName: 'Carlos Alberto Ramírez',
      area: 'Finanzas',
      jobPosition: 'Analista Financiero',
      gender: 'Masculino',
      birthDate: DateTime(1988, 11, 5),
      hireDate: DateTime(2021, 6, 15),
      isActive: true,
    ),
    EmployeeModel(
      id: '3',
      fullName: 'Lucía Navarro Peña',
      area: 'Recursos Humanos',
      jobPosition: 'Coordinadora de Talento Humano',
      gender: 'Femenino',
      birthDate: DateTime(1993, 7, 22),
      hireDate: DateTime(2020, 9, 1),
      isActive: false, // Inactivo: permite ver el estilo sin registrar nada
    ),
    EmployeeModel(
      id: '4',
      fullName: 'Andrés Felipe Ortega',
      area: 'Operaciones',
      jobPosition: 'Gerente de Operaciones',
      gender: 'Masculino',
      birthDate: DateTime(1985, 1, 30),
      hireDate: DateTime(2017, 3, 13),
      isActive: true,
    ),
    EmployeeModel(
      id: '5',
      fullName: 'Sofía Herrera Ríos',
      area: 'Ventas',
      jobPosition: 'Ejecutiva Comercial',
      gender: 'Femenino',
      birthDate: DateTime(1995, 9, 8),
      hireDate: DateTime(2023, 4, 17),
      isActive: true,
    ),
    EmployeeModel(
      id: '6',
      fullName: 'Daniel Esteban Cruz',
      area: 'Administración',
      jobPosition: 'Asistente Administrativa',
      gender: 'Masculino',
      birthDate: DateTime(1999, 12, 2),
      hireDate: DateTime(2024, 1, 8),
      isActive: false,
    ),
  ];

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    await Future<void>.delayed(_latency);
    return List<EmployeeModel>.unmodifiable(_employees);
  }

  @override
  Future<EmployeeModel> addEmployee(EmployeeModel employee) async {
    await Future<void>.delayed(_latency);
    final EmployeeModel created = employee.copyWith(
      id: '${_sequence++}'.padLeft(3, '0'),
    );
    _employees = <EmployeeModel>[..._employees, created];
    return created;
  }

  @override
  Future<EmployeeModel?> updateStatus(String id, bool isActive) async {
    await Future<void>.delayed(_latency);
    final int index = _employees.indexWhere((EmployeeModel e) => e.id == id);
    if (index == -1) return null;

    final EmployeeModel updated = _employees[index].copyWith(
      isActive: isActive,
    );
    final List<EmployeeModel> next = List<EmployeeModel>.of(_employees);
    next[index] = updated;
    _employees = next;
    return updated;
  }
}
