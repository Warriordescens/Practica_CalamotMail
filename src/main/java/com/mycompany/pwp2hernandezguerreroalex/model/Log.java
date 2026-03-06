/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author admin
 */
public class Log {
    
    private int id;
    private User user;
    private LogType type;
    private LocalDateTime date;

    public Log(int id, User user, LogType type, LocalDateTime date) {
        this.id = id;
        this.user = user;
        this.type = type;
        this.date = date;
    }

    public Log(int id, LogType type, LocalDateTime date) {
        this.id = id;
        this.type = type;
        this.date = date;
    }

    public void setUser(User user) {
        this.user = user;
    }

    
    
    public String getDate() {   // paso la fecha directa para mostrarla, no la quiero para nada mas
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return date.format(formatter);
    }

    public User getUser() {
        return user;
    }
    
    
    
}
