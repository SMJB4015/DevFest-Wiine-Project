package com.example.df.repository;

import com.example.df.entitys.Marker;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MarkerRepository extends MongoRepository<Marker, String> {

}
