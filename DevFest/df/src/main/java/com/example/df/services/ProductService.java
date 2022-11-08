package com.example.df.services;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Product;

import java.util.List;

public interface ProductService {
    Product AddProduct(Product product);
    Product FindProductById(String ProductId);
    Void DeleteProduct(String id);
    List<Product> findAll();
    List<Marker> findAllMArkers(String name);

}
