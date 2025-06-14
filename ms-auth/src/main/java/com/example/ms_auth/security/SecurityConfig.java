package com.example.ms_auth.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain; // Importación necesaria para Spring Security 6+

@Configuration
public class SecurityConfig {

    @Bean // Este método ahora se define como un bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            // Mantiene la funcionalidad de deshabilitar CSRF
            .csrf(csrf -> csrf.disable()) // Nueva sintaxis para configurar CSRF en Spring Security 6

            // Mantiene la funcionalidad de permitir todas las solicitudes sin autenticación
            .authorizeHttpRequests(authorize -> authorize
                .anyRequest().permitAll()
            );

        return http.build(); // Construye y devuelve la cadena de filtros de seguridad
    }
}