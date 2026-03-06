/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.controller;

import com.google.gson.Gson;
import com.mycompany.pwp2hernandezguerreroalex.dao.CalamotMailDAO;
import com.mycompany.pwp2hernandezguerreroalex.model.AnswerTO;
import java.io.IOException;
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
@WebServlet(name = "AdminDeleteUser", urlPatterns = {"/AdminDeleteUser"})
public class AdminDeleteUser extends HttpServlet {

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
        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        
        try {
            if (CalamotMailDAO.getInstance().hasMessages(username)) {
                answer.setStatus("ERROR");
                answer.setMessage(traduccion.getString("noDeleted"));
            } else {
                CalamotMailDAO.getInstance().deleteUser(username);
                answer.setStatus("OK");
                answer.setMessage(traduccion.getString("userDeleted"));
            }
        } catch (SQLException | ClassNotFoundException ex) {
            answer.setStatus("ERROR");
            answer.setMessage("SQL Error: " + ex.getMessage());
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String answerJson = gson.toJson(answer);
        response.getWriter().write(answerJson);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Delete de usuario con usuario admin";
    }// </editor-fold>

}
