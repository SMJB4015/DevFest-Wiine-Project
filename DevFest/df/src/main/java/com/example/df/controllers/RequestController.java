package com.example.df.controllers;

import com.example.df.entitys.Request;
import com.example.df.services.RequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/Request")
public class RequestController {
    @Autowired
    RequestService requestService;
    @PostMapping("/Add")
    public Request AddRequest(@RequestBody Request request){return requestService.Add(request);}
    @GetMapping("/FindAll")
    public List<Request> FindAll(){return requestService.FindAll();}
    @GetMapping("/FindById/{id}")
    public Request FindById(@PathVariable("id") String id){return requestService.FindById(id);}
    @DeleteMapping("/Delete/{id}")
    public void Delete(@PathVariable("id") String id){requestService.Delete(id);}
}
