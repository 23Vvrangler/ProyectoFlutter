package com.example.ms_chat.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ms_chat.entity.ChatMessage;

import java.util.List;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Integer> {
    // Métodos para obtener el historial de chat entre dos usuarios
    List<ChatMessage> findBySenderIdAndRecipientIdOrderByTimestampAsc(String senderId, String recipientId);
    List<ChatMessage> findBySenderIdInAndRecipientIdInOrderByTimestampAsc(List<String> ids1, List<String> ids2);
}
