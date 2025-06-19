import 'package:app_capac/modelo/UsuarioModelo.dart';
import 'package:dio/dio.dart';
import 'package:app_capac/util/UrlApi.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';


part 'usuario_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class UsuarioApi {
  factory UsuarioApi(Dio dio, {String baseUrl}) = _UsuarioApi;

  static UsuarioApi create() {
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
    return UsuarioApi(dio);
  }

  // Endpoint para el login. Ahora devuelve RespLoginModelo.
  @POST("/auth/login")
  Future<RespLoginModelo> login(@Body() LoginUsuarioModelo usuario);

  // Nuevo endpoint para validar el token y obtener los detalles del usuario
  @GET("/auth/validate")
  Future<RespValidationModelo> validateToken(@Query("token") String token);

  // Ejemplo: Endpoint para obtener un UsuarioModeloCompleto (si lo tienes)
  @GET("/auth/users/{id}")
  Future<UsuarioModeloCompleto> getUsuarioCompleto(@Path("id") int id, @Header("Authorization") String token);

  // Ejemplo: Endpoint para registrar un nuevo UsuarioModeloCompleto (POST completo)
  @POST("/auth/create") // Ajusta esta URL según tu backend
  Future<UsuarioModeloCompleto> registerUsuario(@Body() UsuarioModeloCompleto usuario);
}