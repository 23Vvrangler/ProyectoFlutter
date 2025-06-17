package com.example.msreservaciones.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.msreservaciones.entity.Reserva;

@Service
public interface ReservaService {
    List<Reserva> listar();
    Reserva guardar (Reserva reserva);
    Optional<Reserva> buscarPorId(Integer id);
    Reserva actualizar(Reserva reserva);
    void eliminar(Integer id);
}
