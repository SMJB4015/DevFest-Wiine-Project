package com.example.df.controllers;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Product;
import com.example.df.services.MarkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Marker")
public class MarkerController {
    @Autowired
    private MarkerService markerService;
    @PostMapping("/Add")
    public Marker AddMarker(@RequestBody Marker marker){return markerService.Add(marker);}
    @GetMapping("/FindAll")
    public List<Marker> FindAll(){return markerService.FindAll();}
    @GetMapping("/FindById/{id}")
    public Marker FindById(@PathVariable("id") String id){return markerService.FindById(id);}
    @DeleteMapping("/Delete/{id}")
    public void Delete(@PathVariable("id") String id){markerService.Delete(id);}
    @PostMapping("/AddProduct/{id}")
    public void AddProduct(@PathVariable("id") String id, @RequestBody Product product){markerService.AddProduct(id, product);}
}
