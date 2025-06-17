package com.example.ms_chat.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import java.util.Map;
import java.util.HashMap;
import lombok.extern.slf4j.Slf4j; // <-- Importar Slf4j

import com.example.ms_chat.entity.ChatMessage;
import com.example.ms_chat.service.ChatMessageService;

@Controller
@Slf4j // <-- Añadir la anotación Slf4j
public class ChatWebSocketController {
    private final SimpMessagingTemplate messagingTemplate;
    private final ChatMessageService chatMessageService;

    public ChatWebSocketController(SimpMessagingTemplate messagingTemplate, ChatMessageService chatMessageService) {
        this.messagingTemplate = messagingTemplate;
        this.chatMessageService = chatMessageService;
    }

    @MessageMapping("/chat.sendMessage")
    public void sendMessage(@Payload ChatMessage chatMessage) {
        log.info("Mensaje recibido en sendMessage: {}", chatMessage); // <-- AÑADIR ESTA LÍNEA
        ChatMessage savedMessage = chatMessageService.saveMessage(chatMessage);
        log.info("Mensaje guardado en DB (retornado por el servicio): {}", savedMessage); // <-- AÑADIR ESTA LÍNEA

        if (savedMessage.getRecipientId() != null && !savedMessage.getRecipientId().isEmpty()) {
            log.info("Enviando mensaje privado a receptor {}: {}", savedMessage.getRecipientId(), savedMessage);
            messagingTemplate.convertAndSendToUser(
                savedMessage.getRecipientId(), "/queue/messages", savedMessage
            );
            log.info("Enviando mensaje privado a emisor {}: {}", savedMessage.getSenderId(), savedMessage);
            messagingTemplate.convertAndSendToUser(
                savedMessage.getSenderId(), "/queue/messages", savedMessage
            );
        } else {
            log.info("Enviando mensaje público a /topic/public.messages: {}", savedMessage);
            messagingTemplate.convertAndSend("/topic/public.messages", savedMessage);
        }
    }

    @MessageMapping("/chat.addUser")
    public void addUser(@Payload ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        log.info("Usuario añadiendo en addUser: {}", chatMessage.getSenderId()); // <-- AÑADIR ESTA LÍNEA
        Map<String, Object> sessionAttributes = headerAccessor.getSessionAttributes();

        if (sessionAttributes == null) {
            sessionAttributes = new HashMap<>();
            headerAccessor.setSessionAttributes(sessionAttributes);
        }

        sessionAttributes.put("username", chatMessage.getSenderId());

        chatMessage.setType(ChatMessage.MessageType.JOIN);
        messagingTemplate.convertAndSend("/topic/public.messages", chatMessage);
    }
}
