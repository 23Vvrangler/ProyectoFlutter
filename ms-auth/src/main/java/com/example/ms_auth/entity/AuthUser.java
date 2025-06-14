package com.example.ms_auth.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.time.Instant;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class AuthUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String userName; // Nombre de usuario, debe ser único

    private String password; // Contraseña del usuario, debe ser almacenada de forma segura (ej. encriptada)

    private String email; // Correo electrónico del usuario

    private Instant createdAt; // Fecha de creación del usuario

    private Instant updatedAt; // Fecha de actualización del usuario

    private Boolean enabled; // Indica si el usuario está habilitado

    private Boolean accountLocked; // Indica si la cuenta está bloqueada

    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "authUser"})
    @OneToOne(mappedBy = "authUser", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    @ToString.Exclude
    private UserProfile userProfile;

    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "authUsers"})
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "usuarios_roles", // El nombre de la tabla de unión se mantiene aquí
        joinColumns = @JoinColumn(name = "id_usuario"),
        inverseJoinColumns = @JoinColumn(name = "id_rol")
    )
    @Builder.Default
    @ToString.Exclude
    private Set<Role> roles = new HashSet<>(); // Colección de roles asociados al usuario

    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = Instant.now();
        }
        if (enabled == null) {
            enabled = true;
        }
        if (accountLocked == null) {
            accountLocked = false;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = Instant.now();
    }
}