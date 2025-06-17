package com.example.ms_chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import java.util.Map; // Importar Map
import java.util.HashMap; // Importar HashMap si se va a inicializar

import com.example.ms_chat.entity.ChatMessage;
import com.example.ms_chat.service.ChatMessageService;

@Controller
public class ChatWebSocketController {
    private final SimpMessagingTemplate messagingTemplate;
    private final ChatMessageService chatMessageService;

    public ChatWebSocketController(SimpMessagingTemplate messagingTemplate, ChatMessageService chatMessageService) {
        this.messagingTemplate = messagingTemplate;
        this.chatMessageService = chatMessageService;
    }

    @MessageMapping("/chat.sendMessage")
    public void sendMessage(@Payload ChatMessage chatMessage) {
        ChatMessage savedMessage = chatMessageService.saveMessage(chatMessage);

        if (savedMessage.getRecipientId() != null && !savedMessage.getRecipientId().isEmpty()) {
            messagingTemplate.convertAndSendToUser(
                savedMessage.getRecipientId(), "/queue/messages", savedMessage
            );
            messagingTemplate.convertAndSendToUser(
                savedMessage.getSenderId(), "/queue/messages", savedMessage
            );
        } else {
            messagingTemplate.convertAndSend("/topic/public.messages", savedMessage);
        }
    }

    @MessageMapping("/chat.addUser")
    public void addUser(@Payload ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        Map<String, Object> sessionAttributes = headerAccessor.getSessionAttributes();

        // ¡Manejo de nulidad aquí!
        if (sessionAttributes == null) {
            sessionAttributes = new HashMap<>(); // O un ConcurrentHashMap si se espera concurrencia
            headerAccessor.setSessionAttributes(sessionAttributes); // Establecer el nuevo mapa de atributos
        }

        // Ahora es seguro usar sessionAttributes
        sessionAttributes.put("username", chatMessage.getSenderId());

        chatMessage.setType(ChatMessage.MessageType.JOIN);
        messagingTemplate.convertAndSend("/topic/public.messages", chatMessage);
    }
}
