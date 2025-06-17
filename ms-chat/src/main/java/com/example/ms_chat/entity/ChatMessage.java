package com.example.ms_chat.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
// import jakarta.persistence.ManyToOne;
// import jakarta.persistence.FetchType;
// import jakarta.persistence.JoinColumn;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Data

public class ChatMessage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String senderId; // ID del remitente (cliente o administrador)
    private String recipientId; // ID del destinatario (cliente o administrador)
    private String content; // Contenido del mensaje
    private LocalDateTime timestamp; // Marca de tiempo del mensaje
    private MessageType type; // Tipo de mensaje (CHAT, JOIN, LEAVE, etc.)

    // Podrías tener relaciones a entidades de Usuario si las tuvieras
    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "sender_user_id")
    // private User sender;

    // @ManyToOne(fetch = FetchType.LAZY)
    // @JoinColumn(name = "recipient_user_id")
    // private User recipient;

    public enum MessageType {
        CHAT, JOIN, LEAVE
    } 
}
