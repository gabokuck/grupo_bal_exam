# bal_exam

App Flutter de gestión de empleados: listado, registro y activación/inactivación.

## Stack

- Flutter + Dart
- Clean Architecture (data / domain / presentation)
- `flutter_bloc` (Cubit), `get_it`, `equatable`, `intl`

## Ejecutar

```bash
flutter pub get
flutter run
```

## Estructura

```
lib/
├── app/                 # App, tema y rutas
├── core/                # Constantes y utilidades
├── features/employees/  # data · domain · presentation
├── injection.dart       # Inyección de dependencias
└── main.dart
```

> Los datos son mock en memoria (`MockEmployeeDataSource`), con 300 ms de latencia simulada.
