package com.example.ms_auth.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.ms_auth.dto.AuthUserDto;
import com.example.ms_auth.entity.AuthUser;
import com.example.ms_auth.entity.TokenDto;
import com.example.ms_auth.repository.AuthRepository;
import com.example.ms_auth.security.JwtProvider;
import com.example.ms_auth.services.AuthUserService;

// Se eliminan las importaciones de excepciones personalizadas
// import com.example.ms_auth.exceptions.UserAlreadyExistsException;
// import com.example.ms_auth.exceptions.InvalidCredentialsException;
// import com.example.ms_auth.exceptions.InvalidTokenException;
// import com.example.ms_auth.exceptions.UserNotFoundException;
// import io.jsonwebtoken.JwtException; // Ya no es necesario si no se capturan directamente aquí

@Service
public class AuthUserServiceImpl implements AuthUserService {

    @Autowired
    AuthRepository authRepository;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    JwtProvider jwtProvider;

    @Override
    public AuthUser save(AuthUserDto authUserDto) {
        // Busca si el usuario ya existe por nombre de usuario
        Optional<AuthUser> user = authRepository.findByUserName(authUserDto.getUserName());
        if (user.isPresent()) {
            return null; // Retorna null si el usuario ya existe
        }
        
        // Codifica la contraseña antes de guardar
        String encodedPassword = passwordEncoder.encode(authUserDto.getPassword());
        
        // Construye la entidad AuthUser
        AuthUser authUser = AuthUser.builder()
                .userName(authUserDto.getUserName())
                .password(encodedPassword)
                .build();
        
        // Guarda el nuevo usuario en la base de datos
        return authRepository.save(authUser);
    }

    @Override
    public TokenDto login(AuthUserDto authUserDto) {
        // Busca el usuario por nombre de usuario
        Optional<AuthUser> userOptional = authRepository.findByUserName(authUserDto.getUserName());
        
        // Si el usuario no se encuentra, retorna null
        if (userOptional.isEmpty()) {
            return null;
        }

        AuthUser user = userOptional.get();

        // Comprueba si la contraseña proporcionada coincide con la contraseña codificada
        if (!passwordEncoder.matches(authUserDto.getPassword(), user.getPassword())) {
            return null; // Retorna null si la contraseña es incorrecta
        }
        
        // Si las credenciales son válidas, crea y devuelve un token JWT
        return new TokenDto(jwtProvider.createToken(user));
    }

    @Override
    public TokenDto validate(String token) {
        // Primero, valida el token usando el método `validateToken` (o `validate`) de JwtProvider.
        // Asegúrate que el nombre del método en JwtProvider es validateToken y devuelve boolean.
        if (!jwtProvider.validateToken(token)) {
             return null; // Retorna null si el token no es válido
        }

        // Si el token es válido, procede a extraer el nombre de usuario
        String username = jwtProvider.getUserNameFromToken(token);

        // Verifica si el usuario asociado al token aún existe en la base de datos
        Optional<AuthUser> user = authRepository.findByUserName(username);
        if (user.isEmpty()) {
            return null; // Retorna null si el usuario no existe
        }

        // Si todo es válido, retorna un nuevo TokenDto con el token recibido
        return new TokenDto(token);
    }

    @Override
    public List<AuthUser> lista(){
        return authRepository.findAll();
    }

    @Override
    public Optional<AuthUser> buscarPorId(Integer id) {
        return authRepository.findById(id);
    }
}