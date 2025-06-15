package com.example.ms_auth.services;

import java.util.List;
import java.util.Optional;

import com.example.ms_auth.entity.UserProfile;

public interface UserProfileService {

    UserProfile guardar(UserProfile userProfile);
    List<UserProfile> listar();
    Optional<UserProfile> buscarPorId(Integer id);
    UserProfile actualizar(UserProfile userProfile);
    void eliminar(Integer id);
}