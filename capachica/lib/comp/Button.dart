import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onTap;
  final String label;

  const Button({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2),
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              onTap();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF375534), // Botón principal (verde oscuro)
              foregroundColor: Color(0xFFE3EED4), // Texto en el botón (color claro)
              padding: EdgeInsets.symmetric(vertical: 12), // Padding del botón
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
              ),
              elevation: 2.0, // Sombra del botón
            ),
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE3EED4), // Texto en color claro
              ),
            ),
          ),
        ),
      ),
    );
  }
}