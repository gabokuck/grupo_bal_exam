import 'package:bal_exam/app/app.dart';
import 'package:bal_exam/injection.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const EmployeeApp());
}
