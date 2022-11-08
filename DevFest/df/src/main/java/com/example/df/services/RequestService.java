package com.example.df.services;

import com.example.df.entitys.Marker;
import com.example.df.entitys.Request;

import java.util.List;

public interface RequestService {
    Request Add(Request request);
    void Delete(String id);
    List<Request> FindAll();
    Request FindById(String id);

}
