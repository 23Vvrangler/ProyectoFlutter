// lib/main.dart (o donde esté tu MaterialApp)
import 'package:app_capac/login/login_user.dart';
import 'package:flutter/material.dart';
import 'package:app_capac/theme/AppTheme.dart';
import 'package:app_capac/drawer/navegation_home_screen.dart'; // Para ADMIN
import 'package:app_capac/draweruser/navegation_user_screen.dart'; // Para USER
import 'package:app_capac/util/TokenUtil.dart'; // Para leer el rol inicial

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Este es el callback para cambiar el tema
  void _handleGlobalThemeChange() {
    setState(() {
      // Forzará la reconstrucción del MaterialApp con el nuevo tema
    });
  }

  // Nuevo método para decidir qué pantalla mostrar al inicio
  Widget _getInitialScreen() {
    // Si tienes un token y un rol en TokenUtil, decides la pantalla
    // Esto es para cuando la app inicia o vuelve desde el login
    if (TokenUtil.TOKEN.isNotEmpty && TokenUtil.role == 'ADMIN') {
      return NavigationHomeScreen(onThemeChanged: _handleGlobalThemeChange);
    } else if (TokenUtil.TOKEN.isNotEmpty && TokenUtil.role == 'USER') {
      return NavigationUserScreen(onThemeChanged: _handleGlobalThemeChange);
    }
    // Si no hay token o el rol no coincide, muestra la página de login
    return LoginPage(); // LoginPage no requiere onThemeChanged
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Capachica App',
      theme: AppTheme.useLightMode ? AppTheme.themeDataLight : AppTheme.themeDataDark,
      // La pantalla inicial se decide aquí
      home: _getInitialScreen(),
    );
  }
}