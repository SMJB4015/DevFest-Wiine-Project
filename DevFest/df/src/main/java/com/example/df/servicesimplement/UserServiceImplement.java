package com.example.df.servicesimplement;

import com.example.df.entitys.Message;
import com.example.df.entitys.User;
import com.example.df.repository.MessageRepository;
import com.example.df.repository.UserRepository;
import com.example.df.services.Userservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImplement implements Userservice {
    @Autowired
    UserRepository userRepository;
    @Autowired
    MessageRepository messageRepository;
    @Override
    public User AddUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public void DeleteUser(String UserId) {
        userRepository.deleteById(UserId);

    }

    @Override
    public User FindUserById(String UserId) {
        return userRepository.findById(UserId).get();
    }

    @Override
    public List<User> FindAllUsers() {
        return userRepository.findAll();
    }

    @Override
    public User FindUserByEmail(String email) {

        return userRepository.findByEmail(email);
    }



    @Override
    public void AddMessage(String UserId, Message message) {
        User user= userRepository.findById(UserId).get();
        message=messageRepository.save(message);
        if(user!=null){
            List<Message> messages=new ArrayList<>();
            if (user.getMessages()!=null){
                messages.addAll(user.getMessages());
            }
            messages.add(message);
            user.setMessages(messages);
            userRepository.save(user);
        }
    }

    @Override
    public Boolean mailVerif(String mail) {
        User user = userRepository.findByEmail(mail);
        Boolean res=false;
        if(user==null){
            res=false;
        }
        else {
            res=true;
        }
        return res;
    }
    @Override
    public void addMessage(String senderMail, String receiverMail, Message message) {
        User sender = userRepository.findByEmail(senderMail);
        User receiver=userRepository.findByEmail(receiverMail);
        message=messageRepository.save(message);
        message.setSenderEmail(senderMail);
        if(receiver!=null){
            List<Message> messages=new ArrayList<>();
            if (receiver.getMessages()!=null){
                messages.addAll(sender.getMessages());
            }
            messages.add(message);
            receiver.setMessages(messages);
            userRepository.save(receiver);
        }

    }
    @Override
    public List<User> findUsersMessages(String email) {
        List<User> users=userRepository.findAll();
        List<User> userList=new ArrayList<>();
        for (User user:users
        ) {
            List<Message> messages=user.getMessages();
            if (messages != null) {
                for (Message message:messages
                ) {
                    String mail=message.getSenderEmail();
                    if(mail.equals(email)) {

                        userList.add(user);
                    }



                }


            }


            }
        return userList;
        }







}
