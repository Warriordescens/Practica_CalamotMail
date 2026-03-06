/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.model;

/**
 *
 * @author admin
 */
public class AnswerTO {
    
    private String status;
    private String message;
    private User user;

    public AnswerTO(String status, String message) {
        this.status = status;
        this.message = message;
    }

    public AnswerTO(String status, String message, User user) {
        this.status = status;
        this.message = message;
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
    

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
    
    
    
}
