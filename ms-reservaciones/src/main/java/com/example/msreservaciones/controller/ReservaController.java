package com.example.msreservaciones.controller;

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

import com.example.msreservaciones.entity.Reserva;
import com.example.msreservaciones.service.ReservaService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@RequestMapping("/reservas")
public class ReservaController {
    @Autowired
    private ReservaService reservaService;

    @GetMapping
    ResponseEntity<List<Reserva>> listar(){
        return ResponseEntity.ok(reservaService.listar());
    }
    @PostMapping
    ResponseEntity<Reserva> guardar(@RequestBody Reserva reserva) {
        return ResponseEntity.ok(reservaService.guardar((reserva)));
    }

    @GetMapping("/{id}")
    ResponseEntity<Reserva> buscarPorId(@PathVariable(required = true) Integer id){
        return ResponseEntity.ok(reservaService.buscarPorId(id).get());

    }
    @PutMapping
    ResponseEntity<Reserva> actualizar(@RequestBody Reserva reserva){
        return ResponseEntity.ok(reservaService.actualizar((reserva)));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<List<Reserva>> eliminar(@PathVariable(required = true) Integer id){
        reservaService.eliminar(id);
        return ResponseEntity.ok(reservaService.listar());

    }
}