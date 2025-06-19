import 'package:app_capac/modelo/ReservacionModelo.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:app_capac/util/UrlApi.dart'; // Tu archivo de URLs

part 'reservacion_api.g.dart'; // ¡Importante! Este archivo se generará

@RestApi(baseUrl: UrlApi.urlApix) // Usa la URL base definida en UrlApi
abstract class ReservacionApi {
  // Constructor factory para Retrofit
  factory ReservacionApi(Dio dio, {String baseUrl}) = _ReservacionApi;

  // Método estático para crear una instancia de la API con configuración por defecto
  static ReservacionApi create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: UrlApi.urlApix,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    // Agrega el logger para ver las peticiones y respuestas en la consola
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    return ReservacionApi(dio);
  }

  // --- Endpoints para Reservas ---

  // Obtener todas las reservas
  @GET("/reservas") // Asegúrate de que esta sea la URL correcta en tu backend
  Future<List<ReservacionModelo>> getAllReservas();

  // Obtener una reserva por ID
  @GET("/reservas/{id}")
  Future<ReservacionModelo> getReservaById(@Path("id") int id);

  // Crear una nueva reserva (POST)
  @POST("/reservas")
  Future<ReservacionModelo> createReserva(@Body() ReservacionModelo reserva);

  // Actualizar una reserva existente (PUT)
  @PUT("/reservas")
  Future<ReservacionModelo> updateReserva(@Body() ReservacionModelo reserva);

  // Eliminar una reserva por ID (DELETE)
  @DELETE("/reservas/{id}")
  Future<void> deleteReserva(@Path("id") int id);
}