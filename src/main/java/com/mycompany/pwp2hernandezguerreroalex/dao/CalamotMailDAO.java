/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.dao;

import com.mycompany.pwp2hernandezguerreroalex.exceptions.CalamotMailException;
import com.mycompany.pwp2hernandezguerreroalex.model.Log;
import com.mycompany.pwp2hernandezguerreroalex.model.LogType;
import com.mycompany.pwp2hernandezguerreroalex.model.Message;
import com.mycompany.pwp2hernandezguerreroalex.model.PlastesTO;
import com.mycompany.pwp2hernandezguerreroalex.model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author admin
 */
public class CalamotMailDAO {
    private static CalamotMailDAO instance;
    
    private CalamotMailDAO() {}
    
    public static CalamotMailDAO getInstance() {
        if (instance == null) {
            instance = new CalamotMailDAO();
        }
        return instance;
    }
    
    public User login(String username, String pass) throws SQLException, ClassNotFoundException, CalamotMailException {
        User u = null;
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from user where nom_usuari = '" + username + "';")) {
            if ( rs.next() && checkPassword(rs.getString("pass"), pass) ) {
                String uname = rs.getString("nom_usuari");
                String name = rs.getString("nom");
                boolean admin = rs.getBoolean("type");
                u = new User(uname, name, admin);
            } else {
                throw new CalamotMailException("data.exception");
            }
        } finally {
            desconectar(c);
        }
        return u;
    }
    
    
    private String encrypt( String pass) {
        return BCrypt.hashpw(pass, BCrypt.gensalt());
    }
    
    private boolean checkPassword(String dbpass, String userpass) {
        return BCrypt.checkpw(userpass, dbpass);
    }
    
    public boolean validateUsername(String u) throws SQLException, ClassNotFoundException { 
        Connection c = conectar();
        Statement st = c.createStatement();
        ResultSet rs = st.executeQuery("select * from user where nom_usuari = '" + u +"';");
        boolean existe = rs.next();
        rs.close();
        st.close();
        desconectar(c);
        return existe;
    }
    
    public void insertUser(User u) throws SQLException, ClassNotFoundException, CalamotMailException {  
        if (validateUsername(u.getUsername())){   
            throw new CalamotMailException("dao.userExists");   
        }
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("insert into user values (?, ?, ?, ?);")) { 
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getNom());
            ps.setString(3, encrypt(u.getPass()));
            ps.setBoolean(4, u.getAdmin());
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public User getUser(String username) throws SQLException, ClassNotFoundException {
        User u = null;
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from user where nom_usuari like '" + username + "';")) {
            if (rs.next()) {
                String name = rs.getString("nom");
            boolean type = rs.getBoolean("type");
            u = new User(username, name, type);
            }
        } finally {
            desconectar(c);
        }
        return u;
    }
    
    public List<User> getUsers() throws SQLException, ClassNotFoundException {  
        List<User> users = new ArrayList<>();
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from user;")) {
            while (rs.next()) {
                String username = rs.getString("nom_usuari");
                String nom = rs.getString("nom");
                Boolean admin = rs.getBoolean("type");
                users.add(new User(username, nom, admin));
            }
        } finally {
            desconectar(c);
        }
        return users;
    }
    
    public List<User> getUsers(User u) throws SQLException, ClassNotFoundException {  
        List<User> contactes = new ArrayList<>();
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from user where nom_usuari != '" + u.getUsername() + "';")) {
            while (rs.next()) {
                String username = rs.getString("nom_usuari");
                String nom = rs.getString("nom");
                contactes.add(new User(username, nom));
            }
        } finally {
            desconectar(c);
        }
        return contactes;
    }
    
    public void addLog(String username, LogType type) throws SQLException, ClassNotFoundException {
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("insert into log (user, type, date_event) values (?, ?, ?);")) { 
            ps.setString(1, username);
            ps.setString(2, type.toString());
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public Log getLast(String username) throws SQLException, ClassNotFoundException {
        Log l = null;
        LogType type;
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("SELECT * FROM log WHERE user = '" + username + "' AND type = 'I' ORDER BY date_event DESC LIMIT 1 OFFSET 1;")) {
            if (rs.next()) {
                int id = rs.getInt("idlog");
                LocalDateTime date = rs.getTimestamp("date_event").toLocalDateTime();
                String tipus = rs.getString("type");
                type = tipus.equalsIgnoreCase("I")? LogType.I : tipus.equalsIgnoreCase("C")? LogType.C : LogType.R;
                l = new Log(id, type, date);
            }
        } finally {
            desconectar(c);
        }
        return l;
    }
    
    public void changeName(String newName, String username) throws SQLException, ClassNotFoundException {
        Connection c  = conectar();
        try (PreparedStatement ps = c.prepareStatement("update user set nom = ? where nom_usuari = ?;")) {
            ps.setString(1, newName);
            ps.setString(2, username);
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public void changePass(String pass, String username) throws SQLException, ClassNotFoundException {
        Connection c  = conectar();
        try (PreparedStatement ps = c.prepareStatement("update user set pass = ? where nom_usuari = ?;")) {
            ps.setString(1, encrypt(pass));
            ps.setString(2, username);
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public void changeModif(boolean type, String username, String name) throws SQLException, ClassNotFoundException {
        Connection c  = conectar();
        try (PreparedStatement ps = c.prepareStatement("update user set type = ?, nom = ? where nom_usuari = ?;")) {
            ps.setBoolean(1, type);
            ps.setString(2, name);
            ps.setString(3, username);
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public void sendMail(Message m) throws SQLException, ClassNotFoundException {
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("insert into message (emisor, receptor, date_sent, subject, content, is_read) values (?, ?, ?, ?, ?, ?);")) { 
            ps.setString(1, m.getEmisor().getUsername());
            ps.setString(2, m.getReceptor().getUsername());
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.setString(4, m.getSubject());
            ps.setString(5, m.getContent());
            ps.setBoolean(6, m.isIs_read());
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
        addLog(m.getEmisor().getUsername(), LogType.C);
    }
    
    public List<Message> getMessages(User u) throws SQLException, ClassNotFoundException {
        List<Message> msgs = new ArrayList();
        
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from message where receptor like '" + u.getUsername() + "';")) {
            while (rs.next()) {
                int id = rs.getInt("idmessage");
                String emisor = rs.getString("emisor");
                String subj = rs.getString("subject");
                String content = rs.getString("content");
                LocalDateTime date = rs.getTimestamp("date_sent").toLocalDateTime();
                boolean isread = rs.getBoolean("is_read");  
                msgs.add(new Message(id, date, new User(emisor), u, subj, content, isread));
            }
        } finally {
            desconectar(c);
        }
        
        return msgs;
    }
    
    public Message getMessage(int id) throws SQLException, ClassNotFoundException {
        Message m = null;
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from message where idmessage = '" + id + "';")) {
            if (rs.next()) {
                String emisor = rs.getString("emisor");
                String subj = rs.getString("subject");
                String content = rs.getString("content");
                LocalDateTime date = rs.getTimestamp("date_sent").toLocalDateTime();
                m = new Message( date, new User(emisor), subj, content);
            }
        } finally {
            desconectar(c);
        }
        return m;
    }
    
    public void deleteMessage(int id) throws SQLException, ClassNotFoundException {
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("DELETE FROM message WHERE idmessage = ?;")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public void messageSeen(int id) throws SQLException, ClassNotFoundException {
        Connection c  = conectar();
        try (PreparedStatement ps = c.prepareStatement("update message set is_read = ? where idmessage = ?;")) {
            ps.setBoolean(1, true);
            ps.setInt(2, id);
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public List<Message> getEnviats(User u) throws SQLException, ClassNotFoundException {
        List<Message> msgs = new ArrayList();
        
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from message where emisor like '" + u.getUsername() + "' order by date_sent desc;")) {
            while (rs.next()) {
                int id = rs.getInt("idmessage");
                String emisor = rs.getString("emisor");
                String subj = rs.getString("subject");
                String content = rs.getString("content");
                LocalDateTime date = rs.getTimestamp("date_sent").toLocalDateTime();
                boolean isread = rs.getBoolean("is_read");  
                msgs.add(new Message(id, date, new User(emisor), u, subj, content, isread));
            }
        } finally {
            desconectar(c);
        }
        
        return msgs;
    }
    
    public void deleteUser(String username) throws SQLException, ClassNotFoundException {
        Connection c = conectar();
        try (PreparedStatement ps = c.prepareStatement("DELETE FROM user WHERE nom_usuari = ?;")) {
            ps.setString(1, username);
            ps.executeUpdate();
        } finally {
            desconectar(c);
        }
    }
    
    public boolean hasMessages(String username) throws SQLException, ClassNotFoundException {
        boolean m = false;
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select * from message where emisor like '" + username + "' or receptor like '" + username + "';")) {
            if (rs.next()) {
                m = true;
            }
        } finally {
            desconectar(c);
        }
        return m;
    }
    
    public List<PlastesTO> getPesats() throws SQLException, ClassNotFoundException {
        List<PlastesTO> plastes = new ArrayList();
        
        Connection c = conectar();
        try (Statement st = c.createStatement(); ResultSet rs = st.executeQuery("select user, count(*) as total from log where type = 'C' group by user order by total desc limit 10;")) {
            while (rs.next()) {
                String username = rs.getString(1);
                int msgs = rs.getInt(2);
                plastes.add(new PlastesTO(username, msgs));
            }
        } finally {
            desconectar(c);
        }
        
        return plastes;
    }
    
    
     private Connection conectar() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/calamotmail";
        String user = "root";
        String pass = "root";
        Connection c = DriverManager.getConnection(url, user, pass);
        return c;
    }
    
    private void desconectar(Connection c) throws SQLException {
        c.close();
    }
}
