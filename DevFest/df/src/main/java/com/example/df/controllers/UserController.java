package com.example.df.controllers;

import com.example.df.entitys.Message;
import com.example.df.entitys.User;
import com.example.df.services.Userservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/User")
public class UserController {
    @Autowired
    private Userservice userservice;
    @PostMapping("/Add")
    public User Adduser(@RequestBody User user){
        return userservice.AddUser(user);
    }
    @GetMapping("/FindAll")
    public List<User> findAll(){
        return userservice.FindAllUsers();
    }
    @DeleteMapping("/Delete/{id}")
    public void DeleteUser(@PathVariable("id") String id){ userservice.DeleteUser(id);}
    @GetMapping("/FindByEmail/{email}")
    public User FindByEmail(@PathVariable("email") String email){return userservice.FindUserByEmail(email);}

    @PostMapping("/AddMessage/{userId}")
    public void AddMessage(@RequestBody Message message ,@PathVariable("userId") String id){userservice.AddMessage(id,message);}
    @GetMapping("/MailVerif/{mail}")
    public Boolean mailVerif(@PathVariable("mail") String mail){return userservice.mailVerif(mail);}
    @PostMapping("/addMessage/{sendermail}/{receivermail}")
    public void addMessage(@PathVariable("sendermail") String sendermail, @PathVariable("receivermail") String receivermail ,@RequestBody Message message){
        userservice.addMessage(sendermail,receivermail,message);
    }
    @GetMapping("/findUsersMessages/{email}")
    public List<User> findUsersMessages(@PathVariable("email") String email){return userservice.findUsersMessages(email);}







}
