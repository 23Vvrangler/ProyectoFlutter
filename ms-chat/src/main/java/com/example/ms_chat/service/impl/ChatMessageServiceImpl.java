package com.example.ms_chat.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.ms_chat.entity.ChatMessage;
import com.example.ms_chat.repository.ChatMessageRepository;
import com.example.ms_chat.service.ChatMessageService;

@Service
public class ChatMessageServiceImpl implements ChatMessageService {

    private final ChatMessageRepository chatMessageRepository;

    // Constructor para inyectar ChatMessageRepository
    public ChatMessageServiceImpl(ChatMessageRepository chatMessageRepository) { //
        this.chatMessageRepository = chatMessageRepository; //
    }

    @Override
    public ChatMessage saveMessage(ChatMessage chatMessage) {
        return chatMessageRepository.save(chatMessage);
    }

    @Override
    public List<ChatMessage> findChatMessages(String senderId, String recipientId) {
        // Implementa la lógica para buscar mensajes
        // Esto podría ser complejo, necesitarías un custom query o varias llamadas
        return chatMessageRepository.findBySenderIdAndRecipientIdOrderByTimestampAsc(senderId, recipientId);
    }
}
