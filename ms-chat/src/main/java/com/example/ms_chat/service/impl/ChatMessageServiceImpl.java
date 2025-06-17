package com.example.ms_chat.service.impl;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.example.ms_chat.entity.ChatMessage;
import com.example.ms_chat.repository.ChatMessageRepository;
import com.example.ms_chat.service.ChatMessageService;

public class ChatMessageServiceImpl implements ChatMessageService {
    @Autowired
    private ChatMessageRepository chatMessageRepository;
    
    public ChatMessageServiceImpl(ChatMessageRepository chatMessageRepository) {
        this.chatMessageRepository = chatMessageRepository;
    }

    @Override
    public ChatMessage saveMessage(ChatMessage chatMessage) {
        chatMessage.setTimestamp(LocalDateTime.now());
        return chatMessageRepository.save(chatMessage);
    }

    @Override
    public List<ChatMessage> getChatHistory(String user1Id, String user2Id) {
        // Obtener mensajes donde user1 envió a user2 O user2 envió a user1
        return chatMessageRepository.findBySenderIdInAndRecipientIdInOrderByTimestampAsc(
            Arrays.asList(user1Id, user2Id), Arrays.asList(user1Id, user2Id)
        );
    }
}
