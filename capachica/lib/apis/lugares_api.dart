import 'package:app_capac/modelo/LugaresModelo.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:app_capac/util/UrlApi.dart'; // Tu archivo de URLs

part 'lugares_api.g.dart'; // ¡Importante! Este archivo se generará

@RestApi(baseUrl: UrlApi.urlApix) // Usa la URL base definida en UrlApi
abstract class LugaresApi {
  factory LugaresApi(Dio dio, {String baseUrl}) = _LugaresApi;

  static LugaresApi create() {
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
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
    return LugaresApi(dio);
  }

  // --- Endpoints para Lugares ---

  // Obtener todos los lugares
  @GET("/lugares") // Asegúrate de que esta sea la URL correcta en tu backend
  Future<List<LugaresModelo>> getAllLugares();

  // Obtener un lugar por ID
  @GET("/lugares/{id}")
  Future<LugaresModelo> getLugarById(@Path("id") int id);

  // Crear un nuevo lugar (POST)
  @POST("/lugares")
  Future<LugaresModelo> createLugar(@Body() LugaresModelo lugar);

  // Actualizar un lugar existente (PUT)
  @PUT("/lugares")
  Future<LugaresModelo> updateLugar(@Body() LugaresModelo lugar);

  // Eliminar un lugar por ID (DELETE)
  @DELETE("/lugares/{id}")
  Future<void> deleteLugar(@Path("id") int id);
}