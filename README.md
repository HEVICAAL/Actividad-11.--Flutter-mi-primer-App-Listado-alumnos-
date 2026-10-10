# Registro de alumnos

Aplicación Flutter para consultar y agregar alumnos. Los registros se guardan
en memoria mientras la aplicación está abierta.

Cada alumno se representa con la clase `Persona`, que contiene `name`,
`lastname` y `cuenta`. La pantalla inicial muestra los alumnos registrados en
un `ListView.builder`; el botón **Agregar alumno** abre un formulario con
validación para incorporar nuevos registros a la lista.

## Ejecutar

Abre el proyecto en Android Studio o Visual Studio Code y ejecútalo en un
emulador o dispositivo. También puedes usar:

```bash
flutter pub get
flutter run
```

## Probar

```bash
flutter test
```
