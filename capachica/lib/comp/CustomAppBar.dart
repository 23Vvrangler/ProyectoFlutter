import 'package:flutter/material.dart';
import 'package:app_capac/theme/AppTheme.dart';

// CustomAppBar ahora solo necesita la función para notificar al padre
// sobre los cambios en el tema.
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.onThemeChanged, // Cambiado el nombre para mayor claridad
  }) : preferredSize = const Size.fromHeight(kToolbarHeight); // Usamos kToolbarHeight para la altura estándar del AppBar

  final VoidCallback onThemeChanged; // Función para notificar al padre sobre cambios en el tema

  @override
  final Size preferredSize; // Implementación de PreferredSizeWidget

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // Ya no necesitamos 'accionx' como un campo del estado, se accede vía widget.onThemeChanged

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ColorScheme actual para adaptar los colores del AppBar
    // Esto asegura que los iconos del AppBar utilicen los colores del tema actual
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Center(
        child: AppTheme.useMaterial3
            ? const Text("BOLSA LABORAL") // Estilo Material 3 con mayúsculas
            : const Text("Bolsa Laboral"), // Estilo Material 2 (si decides usarlo)
      ),
      actions: [
        // Botón para cambiar el modo claro/oscuro
        IconButton(
          icon: AppTheme.useLightMode
              ? const Icon(Icons.dark_mode_outlined) // Icono para modo oscuro si está en modo claro
              : const Icon(Icons.light_mode_outlined), // Icono para modo claro si está en modo oscuro
          onPressed: () {
            setState(() {
              AppTheme.useLightMode = !AppTheme.useLightMode;
              widget.onThemeChanged(); // Notificar al padre para reconstruir el MaterialApp
            });
          },
          tooltip: "Cambiar brillo",
        ),
        // Botón para cambiar entre Material 2 y Material 3 (si es necesario)
        IconButton(
          icon: AppTheme.useMaterial3
              ? const Icon(Icons.filter_2) // Icono para M2 si está en M3
              : const Icon(Icons.filter_3), // Icono para M3 si está en M2
          onPressed: () {
            setState(() {
              AppTheme.useMaterial3 = !AppTheme.useMaterial3;
              widget.onThemeChanged(); // Notificar al padre
            });
          },
          tooltip: "Cambiar a Material ${AppTheme.useMaterial3 ? 2 : 3}",
        ),
        // Menú desplegable para seleccionar el color principal
        PopupMenuButton<int>(
          icon: const Icon(Icons.more_vert),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (context) {
            return List.generate(AppTheme.seedColors.length, (index) {
              return PopupMenuItem<int>(
                value: index,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center, // Alineación vertical
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        index == AppTheme.colorSelected
                            ? Icons.color_lens // Icono relleno si está seleccionado
                            : Icons.color_lens_outlined, // Icono de contorno si no
                        color: AppTheme.seedColors[index], // Color del icono según la semilla
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10), // Reducido el padding para mejor espaciado
                      child: Text(AppTheme.seedColorNames[index]), // Nombre del color
                    ),
                  ],
                ),
              );
            });
          },
          onSelected: (selectedIndex) {
            // Se ejecuta cuando se selecciona un elemento del menú
            setState(() {
              AppTheme.colorSelected = selectedIndex;
              widget.onThemeChanged(); // Notificar al padre para reconstruir
            });
          },
        ),
      ],
    );
  }
}