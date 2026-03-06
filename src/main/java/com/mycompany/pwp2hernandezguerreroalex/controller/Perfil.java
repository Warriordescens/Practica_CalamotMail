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
@WebServlet(name = "Perfil", urlPatterns = {"/Perfil"})
public class Perfil extends HttpServlet {

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
        HttpSession session = request.getSession();
        Locale userLocale = (Locale) session.getAttribute("currentLocale");
        ResourceBundle traduccion = ResourceBundle.getBundle("com.mycompany.pwp2hernandezguerreroalex.i18n.messages", userLocale);
        
        User u = (User) session.getAttribute("usuari");
        String loading = request.getParameter("loading");
        Gson gson = new Gson();
        AnswerTO answer = new AnswerTO("", "", u);
        if(!loading.equalsIgnoreCase("loading")){
            String name = request.getParameter("displayName");
            if (name != null) {
                if (name.equalsIgnoreCase(u.getNom())) {
                    answer.setStatus("nom");
                    answer.setMessage(traduccion.getString("profile.sameName"));
                } else {
                    try {
                        CalamotMailDAO.getInstance().changeName(name, u.getUsername());
                        u.setNom(name);
                        answer.setStatus("OK");
                        answer.setMessage(traduccion.getString("profile.nomChange"));
                    } catch (SQLException | ClassNotFoundException ex) {
                        answer.setStatus("ERROR");
                        if (traduccion.containsKey(ex.getMessage())) {
                            answer.setMessage(traduccion.getString(ex.getMessage()));
                        } else {
                            answer.setMessage("Error: " + ex.getMessage());
                        }
                    }
                }
            }
            session.setAttribute("usuari", u);
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

        User u = (User) session.getAttribute("usuari");
        
        String pass1 = request.getParameter("pass1");
        String pass2 = request.getParameter("pass2");

        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        try {   // no comprovo que sigui la mateixa que hi habia per raóns obvies de molestia al personal :)
                if (!pass1.equals(pass2)) {
                    answer.setStatus("ERROR");
                    answer.setMessage(traduccion.getString("passNoPass"));
                } else {
                    CalamotMailDAO.getInstance().changePass(pass1, u.getUsername());
                    answer.setStatus("OK");
                    answer.setMessage(traduccion.getString("profile.passChanged"));
                }
        } catch (SQLException | ClassNotFoundException ex) {
            answer.setStatus("ERROR");
            if (traduccion.containsKey(ex.getMessage())) {
                answer.setMessage(traduccion.getString(ex.getMessage()));
            } else {
                answer.setMessage("Error inesperado: " + ex.getMessage());
            }
        }
        session.setAttribute("usuari", u);
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
        return "Servlet to manage the profile data and functions.";
    }// </editor-fold>

}
