package com.example.ms_auth.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders; // Añadir esta importación
import io.jsonwebtoken.security.Keys; // Añadir esta importación (si no la tienes)
import io.jsonwebtoken.security.SignatureException; // Mantener esta importación
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.example.ms_auth.entity.AuthUser;
import javax.crypto.SecretKey; // Mantener esta importación (si la usas para SecretKey)
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.security.Key; // Añadir esta importación si usas java.security.Key


@Component
public class JwtProvider {

    @Value("${application.security.jwt.secret-key}")
    private String secretKey;

    @Value("${application.security.jwt.expiration}")
    private long expiration;

    private Key getSignInKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String createToken(AuthUser authUser) {
        Map<String, Object> claims = new HashMap<>();
        // Puedes añadir información del usuario a los claims si lo necesitas
        // claims.put("roles", authUser.getRoles()); // Ejemplo
        return Jwts.builder()
                .claims(claims)
                .subject(authUser.getUserName()) // O authUser.getUsername() si tu entidad tiene ese getter
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(getSignInKey(), SignatureAlgorithm.HS256) // Usar getSignInKey()
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            // **CORRECCIÓN LÍNEA 82 (aprox.)**
            Jwts.parser()
                .verifyWith((SecretKey) getSignInKey()) // Usar verifyWith y castear a SecretKey si getSignInKey devuelve Key
                .build()
                .parseClaimsJws(token);
            return true;
        } catch (SignatureException e) {
            System.err.println("Invalid JWT signature: " + e.getMessage());
            return false;
        } catch (io.jsonwebtoken.MalformedJwtException e) {
            System.err.println("Invalid JWT token: " + e.getMessage());
            return false;
        } catch (io.jsonwebtoken.ExpiredJwtException e) {
            System.err.println("JWT token is expired: " + e.getMessage());
            return false;
        } catch (io.jsonwebtoken.UnsupportedJwtException e) {
            System.err.println("JWT token is unsupported: " + e.getMessage());
            return false;
        } catch (java.lang.IllegalArgumentException e) { // Cambiado a java.lang.IllegalArgumentException
            System.err.println("JWT claims string is empty: " + e.getMessage());
            return false;
        }
    }

    public String getUserNameFromToken(String token) {
        Claims claims = Jwts.parser()
                .verifyWith((SecretKey) getSignInKey()) // Usar verifyWith y castear a SecretKey
                .build()
                .parseClaimsJws(token)
                .getBody();
        return claims.getSubject();
    }
}