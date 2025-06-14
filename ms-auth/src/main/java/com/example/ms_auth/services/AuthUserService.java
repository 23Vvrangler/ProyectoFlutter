package com.example.ms_auth.services;

import java.util.List;
import java.util.Optional;

import com.example.ms_auth.dto.AuthUserDto;
import com.example.ms_auth.entity.Authuser;
import com.example.ms_auth.entity.TokenDto;

public interface AuthUserService {

    Authuser save(AuthUserDto authUserDto);
    TokenDto login(AuthUserDto authUserDto);
    TokenDto validate(String token);

    List<Authuser> lista();
    Optional<Authuser> buscarPorId(Integer id);
}