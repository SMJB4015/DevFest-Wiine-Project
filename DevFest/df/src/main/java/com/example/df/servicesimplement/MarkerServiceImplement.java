package com.example.df.servicesimplement;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Product;
import com.example.df.repository.MarkerRepository;
import com.example.df.services.MarkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MarkerServiceImplement implements MarkerService {
    @Autowired
    MarkerRepository markerRepository;


    @Override
    public Marker Add(Marker marker) {
        return markerRepository.save(marker);
    }

    @Override
    public List<Marker> FindAll() {
        return markerRepository.findAll();
    }

    @Override
    public Marker FindById(String id) {
        return markerRepository.findById(id).get();
    }

    @Override
    public void Delete(String id) {
        markerRepository.deleteById(id);
    }

    @Override
    public void AddProduct(String id, Product product) {
        Marker marker=markerRepository.findById(id).get();
        if (marker!=null){
            List<Product> products=new ArrayList<>();
            if (marker.getValable_Products()!=null){
                products.addAll(marker.getValable_Products());
            }
            products.add(product);
            marker.setValable_Products(products);
            markerRepository.save(marker);
        }
    }
}
