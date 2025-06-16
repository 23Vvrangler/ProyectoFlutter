package com.example.mslugares.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.mslugares.entity.Lugares;

@Service
public interface LugaresService {
    List<Lugares> listar();
    Lugares guardar (Lugares lugares);
    Optional<Lugares> buscarPorId (Integer id);
    Lugares actualizar (Lugares lugares);
    void eliminar (Integer id);
}
