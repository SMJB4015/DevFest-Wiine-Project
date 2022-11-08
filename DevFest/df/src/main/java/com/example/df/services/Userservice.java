package com.example.df.services;

import com.example.df.entitys.Message;
import com.example.df.entitys.User;

import java.util.List;

public interface Userservice {
    User AddUser(User user);
    void DeleteUser(String UserId);
    User FindUserById(String UserId);
    List<User> FindAllUsers();
    User FindUserByEmail(String email);

    void AddMessage(String UserId , Message message);
    Boolean mailVerif(String mail);
    void addMessage(String senderMail,String receiverMail, Message message);
    List<User> findUsersMessages(String email);



}
