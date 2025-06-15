package com.example.ms_auth.security;

import com.example.ms_auth.entity.AuthUser; // Importación corregida a AuthUser con 'U' mayúscula
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders; // Necesario para decodificar la clave Base64
import io.jsonwebtoken.security.Keys; // Necesario para crear la SecretKey
import io.jsonwebtoken.ExpiredJwtException; // Excepciones específicas de JWT
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.JwtException; // Para una captura más genérica (si decides usarla)

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey; // Para el tipo de clave SecretKey
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtProvider {

    // Estas propiedades se inyectarán desde application.properties (o Config Server)
    @Value("${application.security.jwt.secret-key}")
    private String secretKey; // Clave secreta para firmar/verificar JWTs

    @Value("${application.security.jwt.expiration}")
    private long expiration; // Tiempo de expiración del token en milisegundos

    /**
     * Genera la SecretKey a partir de la cadena Base64 configurada.
     * Esta clave se usa para firmar y verificar los tokens.
     * @return La SecretKey generada.
     */
    private SecretKey getSignInKey() {
        // Decodifica la clave secreta de Base64 a un arreglo de bytes
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        // Crea una SecretKey usando los bytes decodificados con el algoritmo HMAC-SHA
        return Keys.hmacShaKeyFor(keyBytes);
    }

    /**
     * Crea un token JWT para el usuario autenticado.
     * @param authUser La entidad AuthUser que representa el usuario.
     * @return El token JWT generado como una cadena.
     */
    public String createToken(AuthUser authUser) {
        // Mapa para añadir claims adicionales si son necesarios (e.g., roles)
        Map<String, Object> claims = new HashMap<>();
        // claims.put("roles", authUser.getRoles()); // Ejemplo de añadir roles si existen

        // Construye el token JWT usando la API moderna de JJWT 0.12.x
        return Jwts.builder()
                .claims(claims) // Añade los claims adicionales
                .subject(authUser.getUserName()) // Establece el asunto (generalmente el nombre de usuario)
                .issuedAt(new Date(System.currentTimeMillis())) // Fecha de emisión del token
                .expiration(new Date(System.currentTimeMillis() + expiration)) // Fecha de expiración del token
                .signWith(getSignInKey()) // Firma el token con la clave secreta generada
                .compact(); // Compacta todas las partes en una cadena de token final
    }

    /**
     * Valida un token JWT.
     * @param token El token JWT a validar.
     * @return true si el token es válido, false en caso contrario.
     */
    public boolean validateToken(String token) {
        try {
            // Crea un parser JWT para verificar el token
            Jwts.parser()
                .verifyWith(getSignInKey()) // Especifica la clave para verificar la firma
                .build() // Construye el parser
                .parseClaimsJws(token); // Parsea y valida el token
            return true; // Si no hay excepciones, el token es válido
        } catch (SignatureException e) {
            // Error si la firma del JWT es inválida (token modificado o clave incorrecta)
            System.err.println("Invalid JWT signature: " + e.getMessage());
        } catch (MalformedJwtException e) {
            // Error si el JWT no está bien formado
            System.err.println("Invalid JWT token: " + e.getMessage());
        } catch (ExpiredJwtException e) {
            // Error si el token JWT ha expirado
            System.err.println("JWT token is expired: " + e.getMessage());
        } catch (UnsupportedJwtException e) {
            // Error si el JWT no es compatible (e.g., usa un algoritmo no soportado)
            System.err.println("JWT token is unsupported: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            // Error si el string de claims del JWT está vacío o es nulo
            System.err.println("JWT claims string is empty: " + e.getMessage());
        } catch (Exception e) { // Captura cualquier otra excepción inesperada durante la validación
            System.err.println("Unexpected error during JWT token validation: " + e.getMessage());
        }
        return false; // Cualquier excepción indica que el token no es válido
    }

    /**
     * Extrae el nombre de usuario (subject) de un token JWT.
     * Asume que el token ya ha sido validado previamente.
     * @param token El token JWT del cual extraer el nombre de usuario.
     * @return El nombre de usuario.
     * @throws JwtException Si no se puede parsear el token o extraer el subject (ej., token inválido).
     */
    public String getUserNameFromToken(String token) {
        // Parsear el token para obtener los claims
        Claims claims = Jwts.parser()
                .verifyWith(getSignInKey()) // Usa la clave para verificar y parsear
                .build()
                .parseClaimsJws(token) // Parsea el token con su firma
                .getBody(); // Obtiene el cuerpo (payload) del token que contiene los claims
        
        // Retorna el 'subject' del token, que generalmente contiene el nombre de usuario
        return claims.getSubject();
    }
}