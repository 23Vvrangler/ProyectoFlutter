import 'package:app_capac/drawer/navegation_home_screen.dart'; // Mantén el import por si lo necesitas temporalmente
import 'package:app_capac/draweruser/navegation_user_screen.dart'; // Mantén el import por si lo necesitas temporalmente
import 'package:app_capac/modelo/UsuarioModelo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_capac/apis/usuario_api.dart';
import 'package:app_capac/util/TokenUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_capac/main.dart'; // ¡Importa tu archivo main.dart!

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  bool passwordVisible = true;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<bool> performLogin(String userName, String password) async {
    final api = UsuarioApi.create();
    try {
      final loginRequest = LoginUsuarioModelo(userName: userName, password: password);
      print("Datos de login enviados: ${loginRequest.toJson()}");
      final respLogin = await api.login(loginRequest);

      if (respLogin.token.isEmpty) {
        print("Login fallido: Token vacío en la respuesta inicial.");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Credenciales incorrectas o token vacío.")),
          );
        }
        return false;
      }

      final respValidation = await api.validateToken(respLogin.token);
      print("Datos de validación recibidos: ${respValidation.toJson()}");

      if (respValidation.userName != null && respValidation.role != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", respValidation.token); // Usa await aquí

        // Actualizar TokenUtil
        TokenUtil.TOKEN = respValidation.token;
        TokenUtil.userName = respValidation.userName!; // Usar ! ya que verificamos null
        TokenUtil.role = respValidation.role!;       // Usar ! ya que verificamos null
        TokenUtil.localx = false; // Indicar que hay un token válido

        // Ya no navegamos directamente a NavigationHomeScreen/UserScreen aquí.
        // En su lugar, vamos a la raíz de la aplicación para que MyApp decida.
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MyApp(), // Redirige a MyApp para que decida la pantalla inicial
            ),
          );
        }
        return true;
      } else {
        print("Validación fallida: userName o role son nulos después de validar el token.");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error en la validación de usuario. Intente de nuevo.")),
          );
        }
        return false;
      }
    } on DioException catch (e) {
      if (!mounted) return false; // Evitar errores si el widget se desmonta
      // Manejo de errores de Dio
      String message;
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        message = "Error de conexión: tiempo de espera excedido.";
      } else if (e.response != null) {
        if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
          message = "Credenciales incorrectas o acceso no autorizado. Intente de nuevo.";
        } else {
          message = "Error ${e.response?.statusCode}: ${e.response?.data?.toString() ?? 'Error desconocido'}";
        }
        print("Error de respuesta HTTP: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        message = "Error de red. Verifique su conexión a Internet.";
        print("Error de red en la autenticación: ${e.message}");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      return false;
    } catch (e) {
      print("Error inesperado en performLogin: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ocurrió un error inesperado durante el login.")),
        );
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/imagen/Logo_LB.png", height: 180.0),
              const SizedBox(height: 20),
              Text(
                "Bolsa Laboral",
                style: textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 20),
              _buildForm(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _controllerUser,
              textInputAction: TextInputAction.next, // Cambiado a next
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
                hintText: "Usuario",
                labelText: "Usuario",
                helperText: "Introduzca su usuario",
                helperStyle: textTheme.bodySmall!.copyWith(
                    color: colorScheme.onSurfaceVariant),
                labelStyle: MaterialStateTextStyle.resolveWith((states) {
                  if (states.contains(MaterialState.focused)) {
                    return TextStyle(color: colorScheme.primary);
                  }
                  return TextStyle(color: colorScheme.onSurfaceVariant);
                }),
                hintStyle: textTheme.bodyLarge!.copyWith(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.7)),
              ),
              validator: (value) =>
              value!.isEmpty ? 'Ingrese su nombre de usuario' : null,
              style: TextStyle(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _controllerPass,
              obscureText: passwordVisible,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
                hintText: "Contraseña",
                labelText: "Contraseña",
                helperText: "Introduzca su contraseña",
                helperStyle: textTheme.bodySmall!.copyWith(
                    color: colorScheme.onSurfaceVariant),
                labelStyle: MaterialStateTextStyle.resolveWith((states) {
                  if (states.contains(MaterialState.focused)) {
                    return TextStyle(color: colorScheme.primary);
                  }
                  return TextStyle(color: colorScheme.onSurfaceVariant);
                }),
                hintStyle: textTheme.bodyLarge!.copyWith(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.7)),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  color: colorScheme.onSurfaceVariant,
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              validator: (value) =>
              value!.isEmpty ? 'Ingrese su contraseña' : null,
              style: TextStyle(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await performLogin(
                    _controllerUser.text,
                    _controllerPass.text,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Ingresar',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}