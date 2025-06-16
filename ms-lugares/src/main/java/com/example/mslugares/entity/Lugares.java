package com.example.mslugares.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Entity
@Data
public class Lugares{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // id BIGINT

    private String nombre; // nombre VARCHAR(255) NN

    private String descripcion; // descripcion TEXT

    private String direccion; // direccion VARCHAR(255)

    private String numeroTelefono; // numero_telefono VARCHAR(20)

    private BigDecimal calificacionPromedio; // calificacion_promedio DECIMAL(3,2)

    private LocalDateTime creadoEn; // creado_en TIMESTAMP

    private LocalDateTime actualizadoEn; // actualizado_en TIMESTAMP   

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categoria_id") // Nombre de la columna de la clave foránea en la tabla 'lugares'
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"}) // Para evitar problemas de serialización JSON con Lazy Loading
    private CategoriaLugar categoria;
}