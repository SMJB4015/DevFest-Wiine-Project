package com.example.df.servicesimplement;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Request;
import com.example.df.repository.RequestRepository;
import com.example.df.services.RequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RequestServiceImplement implements RequestService {
    @Autowired
    RequestRepository requestRepository;

    @Override
    public Request Add(Request request) {
        return requestRepository.save(request);
    }

    @Override
    public void Delete(String id) {
        requestRepository.deleteById(id);
    }

    @Override
    public List<Request> FindAll() {
        return requestRepository.findAll();
    }

    @Override
    public Request FindById(String id) {
        return requestRepository.findById(id).get();
    }



}
