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

public class Message {
    
    private int id;
    private LocalDateTime fecha;
    private User emisor;
    private User receptor;
    private String subject;
    private String content;
    private boolean is_read;

    public Message(int id, LocalDateTime fecha, User emisor, User receptor, String subject, String content, boolean is_read) {
        this.id = id;
        this.fecha = fecha;
        this.emisor = emisor;
        this.receptor = receptor;
        this.subject = subject;
        this.content = content;
        this.is_read = is_read;
    }

    public Message(User emisor, User receptor, String subject, String content, boolean is_read) {
        this.emisor = emisor;
        this.receptor = receptor;
        this.subject = subject;
        this.content = content;
        this.is_read = is_read;
    }

    public Message(int id, User emisor, User receptor, String subject, String content, boolean is_read) {
        this.id = id;
        this.emisor = emisor;
        this.receptor = receptor;
        this.subject = subject;
        this.content = content;
        this.is_read = is_read;
    }

    public Message(LocalDateTime fecha, User emisor, String subject, String content) {
        this.fecha = fecha;
        this.emisor = emisor;
        this.subject = subject;
        this.content = content;
    }

    public void setEmisor(User emisor) {
        this.emisor = emisor;
    }

    public void setReceptor(User receptor) {
        this.receptor = receptor;
    }
    
    public LocalDateTime getRawFecha() {
        return fecha;
    }

    public int getId() {
        return id;
    }

    public String getFecha() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return fecha.format(formatter);
    }

    public User getEmisor() {
        return emisor;
    }

    public User getReceptor() {
        return receptor;
    }

    public String getSubject() {
        return subject;
    }

    public String getContent() {
        return content;
    }

    public boolean isIs_read() {
        return is_read;
    }
    
    
    
    
}
