package com.example.df.servicesimplement;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Product;
import com.example.df.repository.MarkerRepository;
import com.example.df.repository.ProductRepository;
import com.example.df.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImplement implements ProductService {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    MarkerRepository markerRepository;



    @Override
    public Product AddProduct(Product product) {
        return productRepository.save(product);
    }

    @Override
    public Product FindProductById(String ProductId) {
        return productRepository.findById(ProductId).get();
    }

    @Override
    public Void DeleteProduct(String id) {
        productRepository.deleteById(id);
        return null;
    }

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public List<Marker> findAllMArkers(String name) {
        Product product=productRepository.findByName(name);
        List<Marker> allMarkers = markerRepository.findAll();
        List<Marker> markers = new ArrayList<>();
        for (Marker marker:allMarkers
        ) {
            List<Product> markerProducts = marker.getValable_Products();
            if(markerProducts!=null){
                if(markerProducts.contains(product)){
                    markers.add(marker);
                }
            }

        }

        return markers;
    }




}
