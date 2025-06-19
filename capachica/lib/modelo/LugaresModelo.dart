import 'package:json_annotation/json_annotation.dart';

// IMPORTANT: This 'part' directive is crucial for json_serializable to work.

// It tells build_runner to generate code in 'usuario_modelo.g.dart'

// for all @JsonSerializable classes within this file.

/// Modelo para la solicitud de autenticación (inicio de sesión)

/// Este modelo se usa específicamente para enviar userName y password al endpoint de login.

@JsonSerializable()
class LugaresModelo {
  LugaresModelo({
    this.id,
    required this.nombre,
    this.descripcion,
    this.direccion,
    this.numeroTelefono,
    this.calificacionPromedio,
    this.creadoEn,
    this.actualizadoEn,
    this.categoria, // Según tu JSON de ejemplo, esto es un String.
  });

  final int? id; // ID puede ser nulo para POST (si es autogenerado)
  final String nombre;
  final String? descripcion;
  final String? direccion;
  final String? numeroTelefono;
  final double? calificacionPromedio; // BigDecimal en Java -> double en Dart
  final DateTime? creadoEn;
  final DateTime? actualizadoEn;
  final String? categoria; // Asumiendo que es un String, como en tu JSON de ejemplo

  // Constructor fromJson implementado manualmente
  factory LugaresModelo.fromJson(Map<String, dynamic> json) {
    return LugaresModelo(
      id: json['id'] as int?,
      nombre: json['nombre'] as String? ?? '',
      descripcion: json['descripcion'] as String?,
      direccion: json['direccion'] as String?,
      numeroTelefono: json['numeroTelefono'] as String?,
      calificacionPromedio: (json['calificacionPromedio'] as num?)?.toDouble(),
      creadoEn: json['creadoEn'] != null
          ? DateTime.parse(json['creadoEn'] as String)
          : null,
      actualizadoEn: json['actualizadoEn'] != null
          ? DateTime.parse(json['actualizadoEn'] as String)
          : null,
      categoria: json['categoria'] as String?, // Mapea como String
    );
  }

  // Método toJson implementado manualmente
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nombre': nombre,
    };
    if (id != null) {
      data['id'] = id;
    }
    if (descripcion != null) {
      data['descripcion'] = descripcion;
    }
    if (direccion != null) {
      data['direccion'] = direccion;
    }
    if (numeroTelefono != null) {
      data['numeroTelefono'] = numeroTelefono;
    }
    if (calificacionPromedio != null) {
      data['calificacionPromedio'] = calificacionPromedio;
    }
    if (creadoEn != null) {
      data['creadoEn'] = creadoEn!.toIso8601String();
    }
    if (actualizadoEn != null) {
      data['actualizadoEn'] = actualizadoEn!.toIso8601String();
    }
    if (categoria != null) {
      data['categoria'] = categoria; // Envía como String
    }
    return data;
  }
}