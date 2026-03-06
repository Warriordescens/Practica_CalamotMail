/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.model;

/**
 *
 * @author admin
 */
public class PlastesTO {
    
    private String username;
    private int messageNumber;

    public PlastesTO(String username, int messageNumber) {
        this.username = username;
        this.messageNumber = messageNumber;
    }

    public String getUsername() {
        return username;
    }

    public int getMessageNumber() {
        return messageNumber;
    }
}
