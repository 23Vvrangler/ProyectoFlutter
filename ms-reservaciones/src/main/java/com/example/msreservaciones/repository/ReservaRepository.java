package com.example.msreservaciones.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.msreservaciones.entity.Reserva;

public interface ReservaRepository extends JpaRepository<Reserva, Integer> {
    
}
