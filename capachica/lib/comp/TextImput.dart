import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final IconData? suffixIcon; // Ahora puede ser nulo, como en tu uso actual
  final ValueChanged<String>? onChanged; // Añadimos onChanged para manejar la lógica de validación
  final String? Function(String?)? validator; // Hacemos el validator externo y opcional

  const TextInput({
    super.key,
    this.obscure = false,
    required this.hint,
    required this.controller,
    this.suffixIcon, // Ahora es opcional (nullable)
    this.onChanged,
    this.validator,
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  // Eliminamos hasError aquí, ya que la validación y el estado de error los manejará TextFormField
  // y su InputDecoration.

  @override
  Widget build(BuildContext context) {
    // Accedemos al ColorScheme actual del tema
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        // Usamos surfaceContainerLowest o surface para el fondo del contenedor del TextField.
        // surfaceContainerLowest es una buena opción para Material 3 para un fondo sutil.
        // Si no estás usando Material 3 plenamente, surface o background también son válidos.
        color: colorScheme.surfaceContainerLowest, // Un color de superficie ligeramente más claro
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // El color del borde normal podría ser outline, primary, o una variante de surface.
          // Para el borde de error, usamos colorScheme.error.
          // TextFormField maneja su propio borde de error, así que podemos simplificar esto.
          color: colorScheme.outline, // Un color de borde estándar
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscure,
        onChanged: widget.onChanged, // Pasamos onChanged directamente
        validator: widget.validator, // Pasamos el validator externo
        style: TextStyle(
          // Color del texto que el usuario escribe
          color: colorScheme.onSurface, // Color para texto sobre la superficie
        ),
        decoration: InputDecoration(
          border: InputBorder.none, // Eliminamos el borde interno de InputDecoration
          hintText: widget.hint,
          hintStyle: TextStyle(
            // Color del texto del placeholder
            color: colorScheme.onSurfaceVariant.withOpacity(0.7), // Texto de sugerencia con opacidad
          ),
          // El color de relleno de TextFormField suele ser el mismo que el fondo del contenedor.
          // Si quieres un color diferente para el relleno del input, puedes usar fillColor y filled: true.
          // fillColor: colorScheme.surfaceContainerLowest, // Opcional si quieres un relleno específico
          // filled: true, // Debe ser true para que fillColor tenga efecto
          suffixIcon: widget.suffixIcon != null
              ? Icon(
            widget.suffixIcon,
            size: 16,
            color: colorScheme.onSurfaceVariant, // Color del ícono de sufijo
          )
              : null,
          // Colores de error del TextFormField (cuando validator devuelve un String no nulo)
          errorStyle: TextStyle(
            color: colorScheme.error, // Color del texto de error
          ),
          focusedBorder: UnderlineInputBorder( // Borde cuando el campo está enfocado
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          enabledBorder: UnderlineInputBorder( // Borde cuando el campo está habilitado
            borderSide: BorderSide(color: colorScheme.outline, width: 1),
          ),
          errorBorder: UnderlineInputBorder( // Borde cuando hay un error
            borderSide: BorderSide(color: colorScheme.error, width: 1),
          ),
          focusedErrorBorder: UnderlineInputBorder( // Borde de error cuando está enfocado
            borderSide: BorderSide(color: colorScheme.error, width: 2),
          ),
        ),
      ),
    );
  }
}