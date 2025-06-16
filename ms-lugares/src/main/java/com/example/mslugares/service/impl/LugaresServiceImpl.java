package com.example.mslugares.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.mslugares.entity.Lugares;
import com.example.mslugares.repository.LugaresRepository;
import com.example.mslugares.service.LugaresService;

@Service
public class LugaresServiceImpl implements LugaresService {
    @Autowired
    private LugaresRepository lugaresRepository;
    
    @Override
    public List<Lugares> listar(){
        return lugaresRepository.findAll();
    }

    @Override
    public Lugares guardar(Lugares lugares){
        return lugaresRepository.save(lugares);
    }

    @Override
    public Optional<Lugares> buscarPorId (Integer id){
        return lugaresRepository.findById(id);
    }

    @Override
    public void eliminar(Integer id) {
        lugaresRepository.deleteById(id);
    }

    @Override
    public Lugares actualizar (Lugares lugares){
        return lugaresRepository.save(lugares);
    }
}