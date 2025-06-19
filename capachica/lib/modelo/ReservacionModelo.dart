import 'package:json_annotation/json_annotation.dart';


// Si NO estás usando json_serializable y prefieres el método manual (NO RECOMENDADO para modelos complejos):
// (No necesitarías las anotaciones @JsonSerializable() ni la directiva 'part')


// Modelo para la entidad de Reserva/Reservación
// Puede usarse tanto para enviar datos (POST/PUT) como para recibir (GET)
// Nota: Según la data JSON proporcionada, este modelo NO incluye el 'id'.
// Si tu API retorna un 'id' en el GET, deberías añadirlo como 'int? id;' y manejarlo.
@JsonSerializable() // Solo si usas json_serializable
class ReservacionModelo {
  ReservacionModelo({
    this.id, // Puede ser null para POST, será no-null para GET/PUT/DELETE
    required this.nombreClient,
    required this.fechaReserva,
    required this.horaReserva,
    required this.numeroPersonas,
    required this.telefono,
  });

  final int? id;
  final String nombreClient;
  final String fechaReserva;
  final String horaReserva;
  final String numeroPersonas; // Mantenido como String según tu entidad Java
  final String telefono;

  // Constructor fromJson implementado manualmente
  factory ReservacionModelo.fromJson(Map<String, dynamic> json) {
    return ReservacionModelo(
      id: json['id'] as int?, // El 'as int?' es importante para manejar si 'id' es null o no está presente
      nombreClient: json['nombreClient'] as String? ?? '',
      fechaReserva: json['fechaReserva'] as String? ?? '',
      horaReserva: json['horaReserva'] as String? ?? '',
      numeroPersonas: json['numeroPersonas'] as String? ?? '',
      telefono: json['telefono'] as String? ?? '',
    );
  }

  // Método toJson implementado manualmente
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'nombreClient': nombreClient,
      'fechaReserva': fechaReserva,
      'horaReserva': horaReserva,
      'numeroPersonas': numeroPersonas,
      'telefono': telefono,
    };
    // Solo incluye el ID si no es nulo. Esto es útil para POST (donde no se envía ID)
    // y para PUT/DELETE (donde sí se enviaría un ID para identificar el recurso).
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}