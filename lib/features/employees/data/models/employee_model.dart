import 'package:bal_exam/features/employees/presentation/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.fullName,
    required super.area,
    required super.jobPosition,
    required super.gender,
    required super.birthDate,
    required super.hireDate,
    required super.isActive,
  });

  factory EmployeeModel.fromEntity(Employee employee) {
    return EmployeeModel(
      id: employee.id,
      fullName: employee.fullName,
      area: employee.area,
      jobPosition: employee.jobPosition,
      gender: employee.gender,
      birthDate: employee.birthDate,
      hireDate: employee.hireDate,
      isActive: employee.isActive,
    );
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      area: json['area'] as String,
      jobPosition: json['jobPosition'] as String,
      gender: json['gender'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      hireDate: DateTime.parse(json['hireDate'] as String),
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'area': area,
      'jobPosition': jobPosition,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'hireDate': hireDate.toIso8601String(),
      'isActive': isActive,
    };
  }

  @override
  EmployeeModel copyWith({
    String? id,
    String? fullName,
    String? area,
    String? jobPosition,
    String? gender,
    DateTime? birthDate,
    DateTime? hireDate,
    bool? isActive,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      area: area ?? this.area,
      jobPosition: jobPosition ?? this.jobPosition,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      hireDate: hireDate ?? this.hireDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    area,
    jobPosition,
    gender,
    birthDate,
    hireDate,
    isActive,
  ];
}
