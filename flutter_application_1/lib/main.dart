import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MiPantalla(),
    );
  }
}

class MiPantalla extends StatefulWidget {
  const MiPantalla({super.key});

  @override
  State<MiPantalla> createState() => _MiPantallaState();
}

class _MiPantallaState extends State<MiPantalla> {
  static const platform = MethodChannel('recursos_android');

  Map<String, dynamic> datos = {};

  Orientation? orientacionActual;
  Locale? idiomaActual;

  Future<void> obtenerRecursos() async {
    try {
      final resultado =
          await platform.invokeMethod('obtenerRecursos');

      if (!mounted) return;

      setState(() {
        datos = Map<String, dynamic>.from(resultado);
      });
    } on PlatformException catch (e) {
      debugPrint('Error: ${e.message}');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final nuevaOrientacion =
        MediaQuery.of(context).orientation;

    final nuevoIdioma =
        Localizations.localeOf(context);

    if (orientacionActual != nuevaOrientacion ||
        idiomaActual != nuevoIdioma) {

      orientacionActual = nuevaOrientacion;
      idiomaActual = nuevoIdioma;

      obtenerRecursos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: datos['colorFondo'] != null
          ? Color(datos['colorFondo'])
          : Colors.white,
      body: Center(
        child: Text(
          datos['saludo'] ?? 'Cargando...',
          style: TextStyle(
            color: datos['colorTexto'] != null
                ? Color(datos['colorTexto'])
                : Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}