/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.controller;

import com.google.gson.Gson;
import com.mycompany.pwp2hernandezguerreroalex.dao.CalamotMailDAO;
import com.mycompany.pwp2hernandezguerreroalex.model.AnswerTO;
import com.mycompany.pwp2hernandezguerreroalex.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Locale;
import java.util.ResourceBundle;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
@WebServlet(name = "AdminModificarUser", urlPatterns = {"/AdminModificarUser"})
public class AdminModificarUser extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userModif = request.getParameter("userModif");
        Gson gson = new Gson();
        AnswerTO answer = new AnswerTO("", "");
        try {
            answer.setUser(CalamotMailDAO.getInstance().getUser(userModif));
        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("errorMessage", ex.getMessage());
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String answerJson = gson.toJson(answer);
        PrintWriter out = response.getWriter();
        out.print(answerJson);
        out.flush();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Locale userLocale = (Locale) session.getAttribute("currentLocale");
        ResourceBundle traduccion = ResourceBundle.getBundle("com.mycompany.pwp2hernandezguerreroalex.i18n.messages", userLocale);
        
        String pass = request.getParameter("pass");
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        boolean type = Boolean.parseBoolean(request.getParameter("type"));
        
        boolean changed = false;

        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        try {
            User userActual = CalamotMailDAO.getInstance().getUser(username);
            if(pass != null && !pass.equalsIgnoreCase("")) {
                CalamotMailDAO.getInstance().changePass(pass, username);
                changed = true;
            }

            if (!userActual.getNom().equalsIgnoreCase(name) || userActual.getAdmin() != type) {
                CalamotMailDAO.getInstance().changeModif(type, username, name);
                answer.setMessage(traduccion.getString("admin.modif.ok"));
                answer.setStatus("OK");
                changed = true;
            }
            
            if (!changed) {
                answer.setMessage(traduccion.getString("admin.sameData"));
                answer.setStatus("ERROR");
            }
            
            
        } catch (SQLException | ClassNotFoundException ex) {
            answer.setStatus("ERROR");
            if (traduccion.containsKey(ex.getMessage())) {
                answer.setMessage(traduccion.getString(ex.getMessage()));
            } else {
                answer.setMessage("Error inesperado: " + ex.getMessage());
            }
        }
        String answerJson = gson.toJson(answer);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(answerJson);
        out.flush();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to manage the modifying of an user methods";
    }// </editor-fold>

}
