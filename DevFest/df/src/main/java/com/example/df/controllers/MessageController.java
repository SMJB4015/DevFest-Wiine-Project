package com.example.df.controllers;

import com.example.df.entitys.Message;
import com.example.df.services.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/Message")
public class MessageController {
    @Autowired
    private MessageService messageService;
    @PostMapping("/Add")
    public Message AddMessage(@RequestBody Message message){return messageService.AddMessage(message);}
}
