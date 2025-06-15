package com.example.ms_auth.security;

import com.example.ms_auth.entity.AuthUser; // Importación corregida a AuthUser con 'U' mayúscula
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders; // Necesario para decodificar la clave Base64
import io.jsonwebtoken.security.Keys; // Necesario para crear la SecretKey
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey; // Para el tipo de clave SecretKey

import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtProvider {

    @Value("${jwt.secret}")
    private String secret;

    @PostConstruct
    protected void init() {
        this.secret = Base64.getEncoder().encodeToString(secret.getBytes());
    }

    private SecretKey getSignInKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secret);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public String createToken(AuthUser authUser) {
        Map<String, Object> claims = new HashMap<>();

        Date now = new Date(System.currentTimeMillis());
        // Define aquí directamente la duración si no la quieres en las propiedades
        // Por ejemplo, 3600000 milisegundos = 1 hora
        long fixedExpirationMillis = 3600000; 
        Date exp = new Date(now.getTime() + fixedExpirationMillis); 

        return Jwts.builder()
                .claims(claims)
                .subject(authUser.getUserName())
                .claim("id", authUser.getId())
                .issuedAt(now)
                .expiration(exp) // Usa 'exp' con la duración fija
                .signWith(getSignInKey())
                .compact();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parser()
                .verifyWith(getSignInKey())
                .build()
                .parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String getUserNameFromToken(String token) {
        try {
            Claims claims = Jwts.parser()
                    .verifyWith(getSignInKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            return claims.getSubject();
        } catch (Exception e) {
            return "bad token";
        }
    }
}