import 'package:flutter/material.dart';

import 'models/persona.dart';

void main() {
  runApp(const AlumnosApp());
}

class AlumnosApp extends StatelessWidget {
  const AlumnosApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2457A7);

    return MaterialApp(
      title: 'Alumnos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surface: const Color(0xFFF5F7FB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF5F7FB),
          foregroundColor: Color(0xFF172B4D),
          centerTitle: false,
        ),
        useMaterial3: true,
      ),
      home: const AlumnosPage(),
    );
  }
}

class AlumnosPage extends StatefulWidget {
  const AlumnosPage({super.key});

  @override
  State<AlumnosPage> createState() => _AlumnosPageState();
}

class _AlumnosPageState extends State<AlumnosPage> {
  final List<Persona> _alumnos = [
    Persona(name: 'Ana', lastname: 'García', cuenta: 'A001'),
    Persona(name: 'Carlos', lastname: 'López', cuenta: 'A002'),
    Persona(name: 'María Fernanda', lastname: 'Ruiz', cuenta: 'A003'),
  ];

  Future<void> _agregarAlumno() async {
    final persona = await showDialog<Persona>(
      context: context,
      builder: (context) => const _AgregarAlumnoDialog(),
    );

    if (persona != null && mounted) {
      setState(() => _alumnos.add(persona));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alumnos',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tu grupo, organizado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Consulta y administra el registro de alumnos.',
                    style: TextStyle(color: Color(0xFFE4ECFA), fontSize: 14),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      '${_alumnos.length} ${_alumnos.length == 1 ? 'alumno registrado' : 'alumnos registrados'}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Text(
              'Listado de alumnos',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF172B4D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _alumnos.isEmpty
                ? const _ListaVacia()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: _alumnos.length,
                    itemBuilder: (context, index) {
                      final alumno = _alumnos[index];
                      return _AlumnoCard(alumno: alumno);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarAlumno,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Agregar alumno'),
      ),
    );
  }
}

class _AlumnoCard extends StatelessWidget {
  const _AlumnoCard({required this.alumno});

  final Persona alumno;

  @override
  Widget build(BuildContext context) {
    final initials = [
      alumno.name.trim().characters.first,
      alumno.lastname.trim().characters.first,
    ].join().toUpperCase();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE8EDF5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFFEAF0FB),
          child: Text(
            initials,
            style: const TextStyle(
              color: Color(0xFF2457A7),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          alumno.fullName,
          style: const TextStyle(
            color: Color(0xFF172B4D),
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text('Cuenta: ${alumno.cuenta}'),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF8795AA)),
      ),
    );
  }
}

class _ListaVacia extends StatelessWidget {
  const _ListaVacia();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.groups_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            const Text(
              'Aún no hay alumnos registrados',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              'Usa “Agregar alumno” para comenzar.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AgregarAlumnoDialog extends StatefulWidget {
  const _AgregarAlumnoDialog();

  @override
  State<_AgregarAlumnoDialog> createState() => _AgregarAlumnoDialogState();
}

class _AgregarAlumnoDialogState extends State<_AgregarAlumnoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _cuentaController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _cuentaController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      Persona(
        name: _nameController.text.trim(),
        lastname: _lastnameController.text.trim(),
        cuenta: _cuentaController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar alumno'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: _campoRequerido,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastnameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: _campoRequerido,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cuentaController,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _guardar(),
                decoration: const InputDecoration(
                  labelText: 'Cuenta',
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: _campoRequerido,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _guardar, child: const Text('Guardar')),
      ],
    );
  }

  String? _campoRequerido(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }
}
