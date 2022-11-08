package com.example.df.services;


import com.example.df.entitys.Marker;
import com.example.df.entitys.Product;

import java.util.List;

public interface MarkerService {
    Marker Add(Marker marker);
    List<Marker> FindAll();
    Marker FindById(String id);
    void  Delete(String id);
    void AddProduct(String id, Product product);
}
