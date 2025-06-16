package com.example.mslugares.entity;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Entity
@Data
public class CategoriaLugar {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // id BIGINT
    private String nombre; // nombre VARCHAR(100) NN
    private String urlImagen;
    private LocalDateTime creadoEn;

    @OneToMany(mappedBy = "categoria", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnoreProperties({"categoria"}) // Para evitar bucles infinitos en JSON
    private Set<Lugares> lugares = new HashSet<>();
}