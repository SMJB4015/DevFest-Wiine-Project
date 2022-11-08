package com.example.df.servicesimplement;

import com.example.df.entitys.Message;
import com.example.df.repository.MessageRepository;
import com.example.df.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImplement implements MessageService {
    @Autowired
    MessageRepository messageRepository;
    @Override
    public Message AddMessage(Message message) {
        return messageRepository.save(message);
    }
}
