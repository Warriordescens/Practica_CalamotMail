/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.controller;

import com.google.gson.Gson;
import com.mycompany.pwp2hernandezguerreroalex.dao.CalamotMailDAO;
import com.mycompany.pwp2hernandezguerreroalex.exceptions.CalamotMailException;
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
@WebServlet(name = "AdminCreateUser", urlPatterns = {"/AdminCreateUser"})
public class AdminCreateUser extends HttpServlet {

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

        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String pass = request.getParameter("pass");
        boolean type = Boolean.parseBoolean(request.getParameter("type"));

        
        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        if (name != null && !name.equalsIgnoreCase("") && pass != null && !pass.equalsIgnoreCase("")) {
            try {
                if (username != null && CalamotMailDAO.getInstance().validateUsername(username)) {
                    answer.setStatus("USERNAME");
                    answer.setMessage(traduccion.getString("dao.userExists"));
                } else {
                    User u = new User(username, name, pass, type);
                    CalamotMailDAO.getInstance().insertUser(u);
                    answer.setStatus("OK");
                    answer.setMessage(traduccion.getString("registre.ok"));
                }
            } catch (CalamotMailException | SQLException | ClassNotFoundException ex) {
                answer.setStatus("ERROR");
                if (traduccion.containsKey(ex.getMessage())) {
                    answer.setMessage(traduccion.getString(ex.getMessage()));
                } else {
                    answer.setMessage("Error: " + ex.getMessage());
                }
            }
        } else {
            answer.setStatus("ERROR");
            answer.setMessage(traduccion.getString("send.missingFields"));
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
        return "Servlet to manage the creation of a user from an admin";
    }// </editor-fold>

}
