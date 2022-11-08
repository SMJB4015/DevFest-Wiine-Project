package com.example.df.entitys;

import lombok.Data;
import org.springframework.data.annotation.Id;

import java.util.List;

@Data
public class Marker {
    @Id
    private String id;
    private Double lat;
    private Double longeur;
    private  List<Product> valable_Products;
    private String placeN ;


}
