package com.example.mslugares.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.mslugares.entity.CategoriaLugar;

@Service
public interface CategoriaLugarService {
    // Métodos para manejar las categorías de lugares
    List<CategoriaLugar> listar();
    CategoriaLugar guardar(CategoriaLugar categoriaLugar);
    Optional<CategoriaLugar> buscarPorId(Integer id);
    CategoriaLugar actualizar(CategoriaLugar categoriaLugar);
    void eliminar(Integer id);
}
