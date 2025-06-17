package com.example.msreservaciones.service.Impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.msreservaciones.entity.Reserva;
import com.example.msreservaciones.repository.ReservaRepository;
import com.example.msreservaciones.service.ReservaService;

@Service
public class ReservaServiceImpl implements ReservaService {
    @Autowired
    private ReservaRepository reservaRepository;
    
    @Override
    public List<Reserva> listar() {
        return reservaRepository.findAll();
    }

    @Override
    public Reserva guardar(Reserva reserva){
        return reservaRepository.save(reserva);
    }

    @Override
    public Reserva actualizar (Reserva reserva){
        return reservaRepository.save(reserva);
    }

    @Override
    public Optional<Reserva> buscarPorId(Integer id){
        return reservaRepository.findById(id);
    }

    @Override
    public void eliminar(Integer id) {
        reservaRepository.deleteById(id);
    }
}
