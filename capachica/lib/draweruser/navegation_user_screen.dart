import 'package:app_capac/draweruser/drawuser_controller.dart';
import 'package:app_capac/draweruser/user_drawuser.dart'; // Asumo que UserDrawer es el HomeDrawer para el usuario
import 'package:app_capac/theme/AppTheme.dart';
import 'package:app_capac/ui/help_screen.dart'; // Asegúrate de que la ruta sea correcta
import 'package:app_capac/comp/CustomAppBar.dart'; // Importa el CustomAppBar rediseñado
import 'package:flutter/material.dart';

class NavigationUserScreen extends StatefulWidget {
  // NavigationUserScreen también necesita un callback para notificar al padre
  // sobre cambios de tema, si el CustomAppBar se va a usar aquí.
  final VoidCallback onThemeChanged;

  const NavigationUserScreen({super.key, required this.onThemeChanged});

  @override
  _NavigationUserScreenState createState() => _NavigationUserScreenState();
}

class _NavigationUserScreenState extends State<NavigationUserScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const HelpScreen(); // Usar const si es posible
    super.initState();
  }

  // Este método será llamado por CustomAppBar para notificar cambios de tema
  void _handleAppBarThemeChange() {
    // Llama al callback proporcionado por el widget padre (main.dart)
    // para que el MaterialApp reconstruya y aplique el nuevo tema.
    widget.onThemeChanged();

    // Si alguna parte de NavigationUserScreen (como el color del Scaffold)
    // necesita ser reconstruida debido al cambio de tema, haz un setState aquí.
    setState(() {
      // Forzar la reconstrucción de NavigationUserScreen para reflejar cambios
      // en propiedades dependientes del tema que no estén en screenView.
    });
  }


  @override
  Widget build(BuildContext context) {
    // Accede al ColorScheme del tema actual (light o dark)
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      child: SafeArea(
        // top: false, // Puedes quitar SafeArea si ya tienes un AppBar y quieres que ocupe todo el espacio.
        // bottom: false, // Depende si quieres que el body ocupe el área de la barra de navegación
        child: Scaffold(
          // El color de fondo del Scaffold debe ser del ColorScheme actual
          backgroundColor: colorScheme.background, // O colorScheme.surface
          appBar: CustomAppBar(
            onThemeChanged: _handleAppBarThemeChange, // Pasa el callback
          ),
          body: DrawuserController(
            screenIndex: drawerIndex ?? DrawerIndex.HOME, // Null-safety con ??
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView ?? const Text("Error: No screen view"), // Null-safety con ??
            drawerIsOpen: (bool ) {
              // Puedes usar este callback si necesitas saber si el drawer está abierto/cerrado
              // y realizar alguna acción aquí en NavigationUserScreen.
            },
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      // Asegúrate de que si cambias de pantalla, estas también se beneficien del tema
      // y, si tienen AppBar, reciban el callback.
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const HelpScreen(); // Principal
        });
      }
      // else if (drawerIndex == DrawerIndex.PROFILE) {
      //   setState(() {
      //     screenView = const ProfileScreen(); // Por ejemplo, una pantalla de perfil
      //   });
      // }
      // ... Añade más casos para otros índices del drawer
    }
  }
}