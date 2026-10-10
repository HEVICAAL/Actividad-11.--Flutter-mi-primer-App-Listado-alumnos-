import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('muestra alumnos registrados en la lista', (tester) async {
    await tester.pumpWidget(const AlumnosApp());

    expect(find.text('3 alumnos registrados'), findsOneWidget);
    expect(find.text('Ana García'), findsOneWidget);
    expect(find.text('Carlos López'), findsOneWidget);
    expect(find.text('María Fernanda Ruiz'), findsOneWidget);
  });

  testWidgets('agrega un alumno desde el formulario', (tester) async {
    await tester.pumpWidget(const AlumnosApp());

    await tester.tap(find.text('Agregar alumno'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Lucía');
    await tester.enterText(fields.at(1), 'Hernández');
    await tester.enterText(fields.at(2), 'A004');
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    expect(find.text('4 alumnos registrados'), findsOneWidget);
    expect(find.text('Lucía Hernández'), findsOneWidget);
    expect(find.text('Cuenta: A004'), findsOneWidget);
  });

  testWidgets('valida los campos obligatorios', (tester) async {
    await tester.pumpWidget(const AlumnosApp());

    await tester.tap(find.text('Agregar alumno'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    expect(find.text('Este campo es obligatorio'), findsNWidgets(3));
    expect(find.text('3 alumnos registrados'), findsOneWidget);
  });
}
