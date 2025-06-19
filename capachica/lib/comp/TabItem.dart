import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap; // Usamos VoidCallback para mayor precisión

  const TabItem({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Acceder al ColorScheme del tema actual
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Colores para el ícono y el texto
    final Color selectedColor = colorScheme.primary; // O colorScheme.onSurface, dependiendo de tu diseño
    final Color unselectedColor = colorScheme.onSurfaceVariant; // O Colors.grey.shade600, etc.

    return InkWell(
      onTap: onTap, // Simplificado
      borderRadius: BorderRadius.circular(8), // Añadido para mejor efecto de InkWell
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? selectedColor : unselectedColor, // Usando colores del tema
              size: 24, // Puedes definir un tamaño fijo o variable si lo necesitas
            ),
            const SizedBox(height: 4), // Pequeño espacio entre ícono y texto
            Text(
              text,
              style: TextStyle(
                color: isSelected ? selectedColor : unselectedColor, // Usando colores del tema
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal, // Descomentado si quieres negrita
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}