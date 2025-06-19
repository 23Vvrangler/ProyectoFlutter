import 'package:json_annotation/json_annotation.dart';

// IMPORTANT: This 'part' directive is crucial for json_serializable to work.

// It tells build_runner to generate code in 'usuario_modelo.g.dart'

// for all @JsonSerializable classes within this file.

/// Modelo para la solicitud de autenticación (inicio de sesión)

/// Este modelo se usa específicamente para enviar userName y password al endpoint de login.

@JsonSerializable()
class LoginUsuarioModelo {
  LoginUsuarioModelo({
    required this.userName,
    required this.password,
  });

  final String userName;
  final String password;

  // Constructor manual fromJson
  factory LoginUsuarioModelo.fromJson(Map<String, dynamic> json) {
    return LoginUsuarioModelo(
      userName: json['userName'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Método manual toJson
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}

/// Modelo para la respuesta de autenticación del login (endpoint /auth/login)
/// Según tus datos, SOLO devuelve el token, userName y role vienen como null.
class RespLoginModelo {
  RespLoginModelo({
    required this.token,
    this.userName, // Ahora puede ser null
    this.role,     // Ahora puede ser null
  });

  final String token;
  final String? userName; // Puede ser null
  final String? role;     // Puede ser null

  // Constructor manual fromJson
  factory RespLoginModelo.fromJson(Map<String, dynamic> json) {
    return RespLoginModelo(
      token: json['token'] ?? '',
      userName: json['userName'], // No se usa ?? '' aquí porque puede ser null
      role: json['role'],         // No se usa ?? '' aquí porque puede ser null
    );
  }

  // Método manual toJson
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userName': userName,
      'role': role,
    };
  }
}

/// Modelo para la respuesta de validación del token (endpoint /auth/validate)
/// Este es el que contendrá el userName y el role correctos.
class RespValidationModelo {
  RespValidationModelo({
    required this.token,
    required this.userName,
    required this.role,
  });

  final String token;
  final String userName; // Aquí userName ya no es null
  final String role;     // Aquí role ya no es null

  // Constructor manual fromJson
  factory RespValidationModelo.fromJson(Map<String, dynamic> json) {
    return RespValidationModelo(
      token: json['token'] ?? '',
      userName: json['userName'] ?? '',
      role: json['role'] ?? '',
    );
  }

  // Método manual toJson
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userName': userName,
      'role': role,
    };
  }
}

/// Modelo completo para la entidad de usuario (AuthUser en Spring Boot).
class UsuarioModeloCompleto {
  UsuarioModeloCompleto({
    required this.id,
    required this.userName,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.createdAt,
    this.updatedAt,
    this.isEnabled,
    this.isAccountLocked,
    required this.role,
  });

  final int id;
  final String userName;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? address;
  final String? profilePictureUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isEnabled;
  final bool? isAccountLocked;
  final UserRole role;

  // Constructor manual fromJson
  factory UsuarioModeloCompleto.fromJson(Map<String, dynamic> json) {
    return UsuarioModeloCompleto(
      id: json['id'] ?? 0,
      userName: json['userName'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      profilePictureUrl: json['profilePictureUrl'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isEnabled: json['isEnabled'],
      isAccountLocked: json['isAccountLocked'],
      role: UserRole.values.firstWhere(
            (e) => e.toString().split('.').last == (json['role'] as String? ?? 'USER').toUpperCase(),
        orElse: () => UserRole.USER, // Rol por defecto si no se encuentra
      ),
    );
  }

  // Método manual toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isEnabled': isEnabled,
      'isAccountLocked': isAccountLocked,
      'role': role.toString().split('.').last, // Convertir enum a String (ej. "ADMIN" o "USER")
    };
  }
}

// Definición de la enumeración para los roles de usuario.
enum UserRole {
  ADMIN,
  USER,
  // Asegúrate de que estos nombres coincidan con los strings que tu backend envía (ej. "ADMIN", "USER").
  // Si tu backend envía 'USER_ADMIN' o 'USER_DEFAULT', asegúrate de añadirlos aquí también.
  // USER_ADMIN,
  // USER_DEFAULT,
}
