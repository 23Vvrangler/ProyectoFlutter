package com.example.ms_auth.services;

import java.util.List;
import java.util.Optional;

import com.example.ms_auth.entity.Role;

public interface RoleService {
    
    Role guardar(Role role);
    List<Role> listar();
    Optional<Role> buscarPorId(Integer id);
    Role actualizar(Role role);
    void eliminar(Integer id);
}
