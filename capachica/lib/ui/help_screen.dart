import 'package:app_capac/comp/CustomAppBar.dart';
import 'package:flutter/material.dart';
// No es necesario importar AppTheme.dart directamente si solo usas Theme.of(context)
// import 'package:app_capac/theme/AppTheme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key}); // Agregado key y const constructor

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  // El método accion ya no es necesario si CustomAppBar usa un VoidCallback
  // y el setState del padre es quien reconstruye el tema.
  // Sin embargo, si tu main.dart todavía lo espera, puedes mantenerlo,
  // pero el nombre más apropiado sería `onThemeChanged` para coincidir con CustomAppBar.
  void onThemeChanged() {
    setState(() {
      // Este setState es para reconstruir _HelpScreenState si algo en HelpScreen
      // dependiera directamente de una propiedad estática de AppTheme que no fuera
      // propagada vía Theme.of(context). Normalmente no es necesario.
      // La reconstrucción del tema ocurre en el MaterialApp padre.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Accede al ColorScheme y TextTheme del tema actual
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Usamos el CustomAppBar. Si el main.dart pasa un VoidCallback para reconstruir,
      // aquí se pasaría: CustomAppBar(onThemeChanged: onThemeChanged)
      // Asumo que el nombre es accionx en tu CustomAppBar actual.
      appBar: CustomAppBar(onThemeChanged: onThemeChanged),
      backgroundColor: colorScheme.background, // Usa el color de fondo del tema
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0), // Ajustado padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Icono de Soporte/Ayuda
              Icon(
                Icons.support_agent,
                size: 100,
                color: colorScheme.primary, // Tonalidad azul formal del tema
              ),
              const SizedBox(height: 32),

              // Título
              Text(
                '¿En qué podemos ayudarte, Administrador?',
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                  // Ajuste sutil de LetterSpacing para un toque más formal y legible
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 16),

              // Descripción
              Text(
                'Parece que necesitas asistencia con nuestra plataforma de Bolsa Laboral. Estamos aquí para brindarte soporte y ayudarte a resolver cualquier inquietud.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge!.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5, // Mayor altura de línea para mejor legibilidad
                ),
              ),
              const SizedBox(height: 40),

              // Sección de Contacto
              _buildContactOption(
                context,
                icon: Icons.chat_bubble_outline,
                title: 'Habla con Soporte',
                subtitle: 'Conéctate con nuestro equipo en tiempo real para asistencia inmediata.', // Descripción más detallada
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Abriendo chat de soporte...'),
                      backgroundColor: colorScheme.secondary, // Snack Bar con color secundario del tema
                      behavior: SnackBarBehavior.floating, // Flotante para mejor apariencia
                    ),
                  );
                  // Implementar navegación a pantalla de chat o lanzar URL
                },
              ),
              const SizedBox(height: 20),

              _buildContactOption(
                context,
                icon: Icons.email_outlined,
                title: 'Enviar un Email',
                subtitle: 'Envíanos tus dudas, sugerencias o problemas por correo electrónico.', // Descripción más detallada
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Abriendo cliente de correo...'),
                      backgroundColor: colorScheme.secondary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // Implementar lanzamiento de email (usar url_launcher)
                },
              ),
              const SizedBox(height: 20),

              _buildContactOption(
                context,
                icon: Icons.call_outlined,
                title: 'Llámanos',
                subtitle: 'Nuestro equipo de soporte telefónico está disponible en horario de oficina.', // Descripción más detallada
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Realizando llamada de soporte...'),
                      backgroundColor: colorScheme.secondary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  // Implementar lanzamiento de llamada (usar url_launcher)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reutilizable para opciones de contacto
  Widget _buildContactOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      // Card ya usa CardThemeData del tema global si no se especifica.
      // Aquí el color se define explícitamente para este tipo de tarjeta.
      color: colorScheme.surfaceVariant, // Un tono formal para las tarjetas
      elevation: 4, // Usará la elevación del CardThemeData, si se establece, o este valor.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Usará el shape del CardThemeData.
      // margin: const EdgeInsets.symmetric(horizontal: 8.0), // Este ya lo tienes
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 36, color: colorScheme.primary), // Icono azul
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600, // Un poco más audaz
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.onSurfaceVariant, // Texto más suave
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}