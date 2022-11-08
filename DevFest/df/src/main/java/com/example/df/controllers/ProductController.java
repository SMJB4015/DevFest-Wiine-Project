package com.example.df.controllers;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Product;
import com.example.df.services.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Product")
public class ProductController {
    @Autowired
    private ProductService productService;
    @PostMapping("/Add")
    public Product AddProduct(@RequestBody Product product){return productService.AddProduct(product);}
    @GetMapping("/FindAll")
    public List<Product> FindAll(){return productService.findAll();}
    @GetMapping("/FindById/{id}")
    public Product FindByID(@PathVariable("id") String id){return productService.FindProductById(id);}
    @DeleteMapping("/Delete/{id}")
    public void Delete(@PathVariable("id") String id){productService.DeleteProduct(id);}
    @GetMapping("/FindMarkers/{productName}")
    public List<Marker> findMarkers(@PathVariable("productName") String productName){return productService.findAllMArkers(productName);}


}
