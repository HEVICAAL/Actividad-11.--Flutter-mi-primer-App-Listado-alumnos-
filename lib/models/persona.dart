class Persona {
  const Persona({
    required this.name,
    required this.lastname,
    required this.cuenta,
  });

  final String name;
  final String lastname;
  final String cuenta;

  String get fullName => '$name $lastname';
}
