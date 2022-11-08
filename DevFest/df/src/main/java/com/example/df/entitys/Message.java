package com.example.df.entitys;

import lombok.Data;
import org.springframework.data.annotation.Id;

@Data
public class Message {
    @Id
    private String id;
    private String senderEmail;
    private String messageText;
    private String date ;


}
