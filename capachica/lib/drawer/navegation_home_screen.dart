
import 'package:app_capac/drawer/drawer_user_controller.dart';
import 'package:app_capac/drawer/home_drawer.dart';
import 'package:app_capac/ui/help_screen.dart'; // Asegúrate de que la ruta sea correcta (lib/screens/help_screen.dart o similar)
import 'package:app_capac/comp/CustomAppBar.dart'; // Importa el CustomAppBar rediseñado
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  // NavigationHomeScreen es ahora el lugar ideal para un callback
  // que le diga al MaterialApp que reconstruya el tema.
  final VoidCallback onThemeChanged;

  const NavigationHomeScreen({super.key, required this.onThemeChanged});

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
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

    // Además, si alguna parte de NavigationHomeScreen (como el color del Scaffold)
    // necesita ser reconstruida debido al cambio de tema, haz un setState aquí.
    setState(() {
      // Forzar la reconstrucción de NavigationHomeScreen para reflejar cambios
      // en propiedades dependientes del tema que no estén en screenView.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Accede al ColorScheme del tema actual (light o dark)
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      // Ya no es necesario especificar el color del Container si el Scaffold lo manejará
      // y si el SafeArea tiene bottom: false, top: false.
      // El Scaffold se encargará de rellenar el espacio.
      // color: colorScheme.background, // o colorScheme.surface
      child: SafeArea(
        // Puedes quitar SafeArea si ya tienes un AppBar y quieres que ocupe todo el espacio.
        // Si lo mantienes, el contenido del body se ajustará por debajo de los notches.
        // top: false, // Depende si quieres que el AppBar ocupe el área de notch
        // bottom: false, // Depende si quieres que el body ocupe el área de la barra de navegación
        child: Scaffold(
          // El color de fondo del Scaffold debe ser del ColorScheme actual
          backgroundColor: colorScheme.background, // O colorScheme.surface
          appBar: CustomAppBar(
            onThemeChanged: _handleAppBarThemeChange, // Pasar el callback
          ),
          body: DrawerUserController(
            screenIndex: drawerIndex ?? DrawerIndex.HOME, // Null-safety con ??
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView ?? const Text("Error: No screen view"), // Null-safety con ??
            drawerIsOpen: (bool) {
              // Puedes usar este callback si necesitas saber si el drawer está abierto/cerrado
              // y realizar alguna acción aquí en NavigationHomeScreen.
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
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = const HelpScreen(); // Otra pantalla de ejemplo
        });
      }
      // Añade más casos para otros índices del drawer
      // else if (drawerIndex == DrawerIndex.FEEDBACK) {
      //   setState(() {
      //     screenView = const FeedbackScreen(); // Asumiendo que existe
      //   });
      // }
      // ...
    }
  }
}