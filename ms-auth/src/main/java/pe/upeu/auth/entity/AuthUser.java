package pe.upeu.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.Entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

@Builder
@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String userName;
    private String password;
    private String email;
    private String firstName;
    private String lastName;
    private LocalDate dateOfBirth;
    private String phoneNumber;
    private String address;
    private String profilePictureUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Boolean isEnabled;
    private Boolean isAccountLocked;
    
    @Enumerated(EnumType.STRING) // IMPORTANTE: Almacena el nombre del enum (ej. "ADMIN", "USER") como String en la DB
    @Column(name = "rol", nullable = false, length = 50) // Crea una columna 'rol' en la tabla 'usuarios_autenticacion'
    private UserRole role;
    
    public enum UserRole {
        ADMIN, // Para administradores
        USER;  // Para usuarios regulares

        // Puedes añadir más roles si es necesario
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        // Establecer valores por defecto si no se especifican al crear
        if (isEnabled == null) {
            isEnabled = true;
        }
        if (isAccountLocked == null) {
            isAccountLocked = false;
        }
        // Asignar "USER" como rol por defecto si no se especifica
        if (role == null) {
            role = UserRole.USER;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}