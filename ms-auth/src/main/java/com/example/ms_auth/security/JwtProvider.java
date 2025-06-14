package com.example.ms_auth.security;

// ==============================================================
// IMPORTACIONES NECESARIAS PARA JJWT 0.12.x Y SPRING BOOT
// ASEGÚRATE DE QUE TODAS ESTÉN PRESENTES Y SEAN CORRECTAS
// ==============================================================
import io.jsonwebtoken.Jwts; // Para Jwts.builder() y Jwts.parserBuilder()
import io.jsonwebtoken.JwtException; // Excepción base para problemas de JWT
import io.jsonwebtoken.security.Keys; // Para Keys.hmacShaKeyFor()
import io.jsonwebtoken.ExpiredJwtException; // Para manejar tokens expirados
import io.jsonwebtoken.MalformedJwtException; // Para tokens con formato incorrecto
import io.jsonwebtoken.SignatureException; // Para problemas con la firma del token
import io.jsonwebtoken.UnsupportedJwtException; // Para tokens con algoritmos no soportados

import jakarta.annotation.PostConstruct; // Para la anotación @PostConstruct

import org.springframework.beans.factory.annotation.Value; // Para inyectar valores desde properties
import org.springframework.stereotype.Component; // Para que Spring gestione esta clase como un componente

import org.slf4j.Logger; // Para logging
import org.slf4j.LoggerFactory; // Para obtener la instancia del logger

import com.example.ms_auth.entity.Authuser; // **¡MUY IMPORTANTE: Asegúrate de que tu entidad se llame AuthUser.java y no Authuser.java!**

import java.security.Key; // Para el objeto Key de la firma
import java.time.Instant; // Para manejar fechas de forma moderna
import java.util.Date; // Necesario porque Jwts.builder().issuedAt() y .expiration() aceptan Date o Instant

@Component
public class JwtProvider {

    private static final Logger logger = LoggerFactory.getLogger(JwtProvider.class);

    @Value("${jwt.secret}")
    private String secret;

    private Key key;

    @PostConstruct
    protected void init() {
        try {
            // Genera una clave HMAC-SHA256 segura a partir de los bytes del secreto.
            // La longitud del secreto en application.properties debe ser suficiente para HS256 (al menos 32 caracteres ASCII).
            this.key = Keys.hmacShaKeyFor(secret.getBytes());
            logger.info("Clave JWT inicializada exitosamente.");
        } catch (Exception e) {
            logger.error("Error crítico al inicializar la clave JWT: {}", e.getMessage(), e);
            throw new RuntimeException("Fallo al inicializar la clave JWT. La aplicación no puede iniciar de forma segura.", e);
        }
    }

    /**
     * Crea un nuevo token JWT para el usuario autenticado.
     * @param authUser El objeto AuthUser con la información para el token.
     * @return El token JWT generado como String.
     */
    public String createToken(Authuser authUser) { // **Asegúrate de que 'AuthUser' aquí es con 'U' mayúscula**
        Instant now = Instant.now();
        // El token expira en 1 hora (3600 segundos). Ajusta según tus requisitos de seguridad.
        Instant expiration = now.plusSeconds(3600); 

        logger.debug("Creando token JWT para el usuario: {}", authUser.getUserName());

        return Jwts.builder()
                .subject(authUser.getUserName()) // Establece el sujeto (generalmente el nombre de usuario)
                .claim("id", authUser.getId())   // Añade el ID del usuario como un claim personalizado
                .issuedAt(Date.from(now))       // Fecha de emisión del token
                .expiration(Date.from(expiration)) // Fecha de expiración del token
                .signWith(key)                   // Firma el token con la clave generada
                .compact();                      // Construye el JWT en su formato compacto (cadena)
    }

    /**
     * Valida la integridad y validez de un token JWT.
     * @param token El token JWT a validar.
     * @return true si el token es válido y no ha sido manipulado ni expirado, false en caso contrario.
     */
    public boolean validate(String token) {
        try {
            // Usa parserBuilder() para construir un parser y luego validar el token.
            // Si el token es inválido, una de las excepciones de JWT será lanzada.
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
            logger.debug("Token JWT validado exitosamente.");
            return true;
        } catch (SignatureException e) { // La firma del token no coincide con la clave.
            logger.error("Firma JWT inválida: {}", e.getMessage());
        } catch (MalformedJwtException e) { // El formato del token JWT es incorrecto.
            logger.error("Token JWT mal formado: {}", e.getMessage());
        } catch (ExpiredJwtException e) { // El token ha expirado.
            logger.error("Token JWT expirado: {}", e.getMessage()); 
        } catch (UnsupportedJwtException e) { // El token utiliza un algoritmo o formato no soportado.
            logger.error("Token JWT no soportado: {}", e.getMessage());
        } catch (IllegalArgumentException e) { // Argumentos inválidos (ej. token nulo o vacío).
            logger.error("Argumento ilegal en token JWT: {}", e.getMessage());
        } catch (Exception e) { // Captura cualquier otra excepción inesperada.
            logger.error("Fallo inesperado durante la validación del token JWT: {}", e.getMessage(), e);
        }
        return false;
    }

    /**
     * Extrae el nombre de usuario (subject) de un token JWT.
     * @param token El token JWT del cual extraer el nombre de usuario.
     * @return El nombre de usuario (String).
     * @throws JwtException Si no se puede extraer el nombre de usuario debido a un token inválido.
     */
    public String getUserNameFromToken(String token){
        try {
            // Parsea el token, obtiene el cuerpo (claims) y extrae el sujeto (que es el nombre de usuario).
            return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token).getBody().getSubject();
        } catch (JwtException e) { // Captura cualquier excepción relacionada con el parseo del JWT.
            logger.error("No se pudo obtener el nombre de usuario del token JWT: {}", e.getMessage());
            throw e; // Relanza la excepción para que el servicio que llama pueda manejarla.
        }
    }
}