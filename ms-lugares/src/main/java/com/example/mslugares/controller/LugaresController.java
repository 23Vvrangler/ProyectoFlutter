package com.example.mslugares.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.mslugares.entity.Lugares;
import com.example.mslugares.service.LugaresService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@RequestMapping("/lugares")
public class LugaresController {
    @Autowired
    private LugaresService lugaresService;

    @GetMapping
    ResponseEntity<List<Lugares>> listar(){
        return ResponseEntity.ok(lugaresService.listar());
    }
    @PostMapping
    ResponseEntity<Lugares> guardar(@RequestBody Lugares lugares) {
        return ResponseEntity.ok(lugaresService.guardar((lugares)));
    }

    @GetMapping("/{id}")
    ResponseEntity<Lugares> buscarPorId(@PathVariable(required = true) Integer id){
        return ResponseEntity.ok(lugaresService.buscarPorId(id).get());
    }

    @PutMapping
    ResponseEntity<Lugares> actualizar(@RequestBody Lugares lugares){
        return ResponseEntity.ok(lugaresService.actualizar((lugares)));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<List<Lugares>> eleminar(@PathVariable(required = true) Integer id){
        lugaresService.eliminar(id);
        return ResponseEntity.ok(lugaresService.listar());
    }
}
