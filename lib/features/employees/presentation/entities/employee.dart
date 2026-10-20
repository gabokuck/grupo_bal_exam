import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  const Employee({
    required this.id,
    required this.fullName,
    required this.area,
    required this.jobPosition,
    required this.gender,
    required this.birthDate,
    required this.hireDate,
    required this.isActive,
  });

  final String id;
  final String fullName;
  final String area;
  final String jobPosition;
  final String gender;
  final DateTime birthDate;
  final DateTime hireDate;
  final bool isActive;

  Employee copyWith({
    String? id,
    String? fullName,
    String? area,
    String? jobPosition,
    String? gender,
    DateTime? birthDate,
    DateTime? hireDate,
    bool? isActive,
  }) {
    return Employee(
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
