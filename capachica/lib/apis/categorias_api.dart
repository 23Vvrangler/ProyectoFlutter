import 'package:app_capac/modelo/CategoriaLugarModelo.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'package:app_capac/util/UrlApi.dart'; // Tu archivo de URLs

part 'categorias_api.g.dart'; // ¡Importante! Este archivo se generará

@RestApi(baseUrl: UrlApi.urlApix) // Usa la URL base definida en UrlApi
abstract class CategoriasApi {
  factory CategoriasApi(Dio dio, {String baseUrl}) = _CategoriasApi;

  static CategoriasApi create() {
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
    return CategoriasApi(dio);
  }

  // --- Endpoints para Categorias ---

  // Obtener todas las categorías
  @GET("/categorias") // Asegúrate de que esta sea la URL correcta en tu backend
  Future<List<CategoriaLugarModelo>> getAllCategorias();

  // Obtener una categoría por ID
  @GET("/categorias/{id}")
  Future<CategoriaLugarModelo> getCategoriaById(@Path("id") int id);

  // Crear una nueva categoría (POST)
  @POST("/categorias")
  Future<CategoriaLugarModelo> createCategoria(@Body() CategoriaLugarModelo categoria);

  // Actualizar una categoría existente (PUT)
  @PUT("/categorias")
  Future<CategoriaLugarModelo> updateCategoria(@Body() CategoriaLugarModelo categoria);

  // Eliminar una categoría por ID (DELETE)
  @DELETE("/categorias/{id}")
  Future<void> deleteCategoria(@Path("id") int id);
}