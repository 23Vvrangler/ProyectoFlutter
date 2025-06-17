package com.example.ms_chat.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.ms_chat.entity.ChatMessage;

@Service
public interface ChatMessageService {
    ChatMessage saveMessage(ChatMessage chatMessage);
    List<ChatMessage> getChatHistory(String user1Id, String user2Id);
}
