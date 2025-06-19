import 'package:app_capac/modelo/LugaresModelo.dart';
import 'package:json_annotation/json_annotation.dart';

// IMPORTANT: This 'part' directive is crucial for json_serializable to work.

// It tells build_runner to generate code in 'usuario_modelo.g.dart'

// for all @JsonSerializable classes within this file.

/// Modelo para la solicitud de autenticación (inicio de sesión)

/// Este modelo se usa específicamente para enviar userName y password al endpoint de login.

@JsonSerializable()
class CategoriaLugarModelo {
  CategoriaLugarModelo({
    this.id,
    required this.nombre,
    required this.urlImagen,
    this.creadoEn,
    this.lugares, // Lista de lugares que pertenecen a esta categoría
  });

  final int? id; // ID puede ser nulo para POST (si es autogenerado)
  final String nombre;
  final String urlImagen;
  final DateTime? creadoEn; // Fecha de creación, generalmente gestionada por el backend
  final List<LugaresModelo>? lugares; // Lista de lugares, puede ser nula

  // Constructor fromJson implementado manualmente
  factory CategoriaLugarModelo.fromJson(Map<String, dynamic> json) {
    // Parsea la lista de lugares si existe y no es nula
    List<LugaresModelo>? parsedLugares;
    if (json['lugares'] != null) {
      parsedLugares = (json['lugares'] as List)
          .map((i) => LugaresModelo.fromJson(i as Map<String, dynamic>))
          .toList();
    }

    return CategoriaLugarModelo(
      id: json['id'] as int?,
      nombre: json['nombre'] as String? ?? '',
      urlImagen: json['urlImagen'] as String? ?? '',
      creadoEn: json['creadoEn'] != null
          ? DateTime.parse(json['creadoEn'] as String)
          : null,
      lugares: parsedLugares,
    );
  }

  // Método toJson implementado manualmente
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nombre': nombre,
      'urlImagen': urlImagen,
    };
    if (id != null) {
      data['id'] = id;
    }
    if (creadoEn != null) {
      data['creadoEn'] = creadoEn!.toIso8601String();
    }
    if (lugares != null) {
      data['lugares'] = lugares!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}