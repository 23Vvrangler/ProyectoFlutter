package com.example.mslugares.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.mslugares.entity.CategoriaLugar;
import com.example.mslugares.service.CategoriaLugarService;

@RestController
@RequestMapping("/categorias-lugar")
public class CategoriaLugarController {
    @Autowired
    private CategoriaLugarService categoriaLugarService;

    @GetMapping
    ResponseEntity<List<CategoriaLugar>> listar(){
        return ResponseEntity.ok(categoriaLugarService.listar());
    }
    @PostMapping
    ResponseEntity<CategoriaLugar> guardar(@RequestBody CategoriaLugar categoriaLugar) {
        return ResponseEntity.ok(categoriaLugarService.guardar((categoriaLugar)));
    }

    @GetMapping("/{id}")
    ResponseEntity<CategoriaLugar> buscarPorId(@PathVariable(required = true) Integer id){
        return ResponseEntity.ok(categoriaLugarService.buscarPorId(id).get());

    }
    @PutMapping
    ResponseEntity<CategoriaLugar> actualizar(@RequestBody CategoriaLugar categoriaLugar){
        return ResponseEntity.ok(categoriaLugarService.actualizar((categoriaLugar)));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<List<CategoriaLugar>> eliminar(@PathVariable(required = true) Integer id){
        categoriaLugarService.eliminar(id);
        return ResponseEntity.ok(categoriaLugarService.listar());

    }
}