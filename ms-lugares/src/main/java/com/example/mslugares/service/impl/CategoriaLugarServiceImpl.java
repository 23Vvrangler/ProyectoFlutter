package com.example.mslugares.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.mslugares.entity.CategoriaLugar;

import com.example.mslugares.repository.CategoriaLugarRepository;
import com.example.mslugares.service.CategoriaLugarService;

@Service
public class CategoriaLugarServiceImpl  implements CategoriaLugarService{
    @Autowired
    private CategoriaLugarRepository categoriaLugarRepository;
    
    @Override
    public List<CategoriaLugar> listar(){
        return categoriaLugarRepository.findAll();
    }

    @Override
    public CategoriaLugar guardar(CategoriaLugar categoriaLugar){
        return categoriaLugarRepository.save(categoriaLugar);
    }

    @Override
    public Optional<CategoriaLugar> buscarPorId (Integer id){
        return categoriaLugarRepository.findById(id);
    }

    @Override
    public void eliminar(Integer id) {
        categoriaLugarRepository.deleteById(id);
    }

    @Override
    public CategoriaLugar actualizar (CategoriaLugar categoriaLugar){
        return categoriaLugarRepository.save(categoriaLugar);
    }
    
}
