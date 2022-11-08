package com.example.df.entitys;

import lombok.Data;
import org.springframework.data.annotation.Id;

import java.util.List;

@Data
public class Request {
    @Id
    private String id;
    private String userId;
    private String markerId;
    private List<Product> products;

}
