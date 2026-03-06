/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.model;

/**
 *
 * @author admin
 */
public class User {
    
    private String username;
    private String nom;
    private String pass;
    private Boolean admin;

    
    
    public User(String username, String nom, String pass, Boolean admin) {
        this.username = username;
        this.nom = nom;
        this.pass = pass;
        this.admin = admin;
    }

    public User(String username, String nom, Boolean admin) {
        this.username = username;
        this.nom = nom;
        this.admin = admin;
    }

    public User(String username, String nom) {
        this.username = username;
        this.nom = nom;
    }
    
    public User(String username) {
        this.username = username;
    }
    

    public String getUsername() {
        return username;
    }

    public String getNom() {
        return nom;
    }

    public String getPass() {
        return pass;
    }

    public Boolean getAdmin() {
        return admin;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
    
    
    
    
}
