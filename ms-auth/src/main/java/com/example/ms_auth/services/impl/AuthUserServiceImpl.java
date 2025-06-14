package com.example.ms_auth.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.ms_auth.dto.AuthUserDto;
import com.example.ms_auth.entity.Authuser;
import com.example.ms_auth.entity.TokenDto;
import com.example.ms_auth.repository.AuthRepository;
import com.example.ms_auth.security.JwtProvider;
import com.example.ms_auth.services.AuthUserService;

@Service
public class AuthUserServiceImpl implements AuthUserService {
    @Autowired
    AuthRepository authRepository;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    JwtProvider jwtProvider;

    @Override
    public Authuser save(AuthUserDto authUserDto) {
        Optional<Authuser> user = authRepository.findByUserName(authUserDto.getUserName());
        if (user.isPresent())
            return null;
        String password = passwordEncoder.encode(authUserDto.getPassword());
        Authuser authUser = Authuser.builder()
                .userName(authUserDto.getUserName())
                .password(password)
                .build();

        return authRepository.save(authUser);
    }

    @Override
    public TokenDto login(AuthUserDto authUserDto) {
        Optional<Authuser> user = authRepository.findByUserName(authUserDto.getUserName());
        if (!user.isPresent())
            return null;
        if (passwordEncoder.matches(authUserDto.getPassword(), user.get().getPassword()))
            return new TokenDto(jwtProvider.createToken(user.get()));
        return null;
    }

    @Override
    public TokenDto validate(String token) {
       if (!jwtProvider.validate(token))
            return null;
        String username = jwtProvider.getUserNameFromToken(token);
        if (!authRepository.findByUserName(username).isPresent())
            return null;

        return new TokenDto(token);
    }

    @Override
    public List<Authuser> lista(){
        return authRepository.findAll();
    }

    @Override
    public Optional<Authuser> buscarPorId(Integer id) {
        return authRepository.findById(id);
    }
}