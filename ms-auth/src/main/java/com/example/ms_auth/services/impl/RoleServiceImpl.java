package com.example.ms_auth.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.ms_auth.entity.Role;
import com.example.ms_auth.repository.RoleRepository;
import com.example.ms_auth.services.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository; 
    @Override
    public List<Role> listar() {
        return roleRepository.findAll();
    }
    @Override
    public Role guardar(Role role) {
        return roleRepository.save(role); 
    }
    @Override
    public Optional<Role> buscarPorId(Integer id) {
        return roleRepository.findById(id); 
    }
    @Override
    public Role actualizar(Role role) {
        return roleRepository.save(role); 
    }
    @Override
    public void eliminar(Integer id) {
        roleRepository.deleteById(id);
    }
}
