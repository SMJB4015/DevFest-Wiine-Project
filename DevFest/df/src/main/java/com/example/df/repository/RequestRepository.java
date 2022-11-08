package com.example.df.repository;

import com.example.df.entitys.Request;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RequestRepository extends MongoRepository <Request , String> {
}
