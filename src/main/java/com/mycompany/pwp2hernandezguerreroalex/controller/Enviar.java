/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.controller;

import com.google.gson.Gson;
import com.mycompany.pwp2hernandezguerreroalex.dao.CalamotMailDAO;
import com.mycompany.pwp2hernandezguerreroalex.model.AnswerTO;
import com.mycompany.pwp2hernandezguerreroalex.model.Message;
import com.mycompany.pwp2hernandezguerreroalex.model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "Enviar", urlPatterns = {"/Enviar"})
public class Enviar extends HttpServlet {

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
        User u = (User) session.getAttribute("usuari");
        List<User> contactes;
        if (u != null) {
            try {
                contactes = CalamotMailDAO.getInstance().getUsers(u);
                request.setAttribute("llistaContactes", contactes);
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(Enviar.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        request.getRequestDispatcher("/enviar.jsp").forward(request, response);
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
        String receptor = request.getParameter("receptor");
        String subject = request.getParameter("assumpte");
        String content = request.getParameter("missatge");
        Message m = new Message(u, new User(receptor), subject, content, false);
        
        AnswerTO answer = new AnswerTO("", "");
        Gson gson = new Gson();
        if (receptor.equalsIgnoreCase("") || subject.equalsIgnoreCase("") || content.equalsIgnoreCase("")) {
            answer.setStatus("ERROR");
            answer.setMessage(traduccion.getString("send.missingFields"));
        } else {
            try {
                CalamotMailDAO.getInstance().sendMail(m);
                answer.setStatus("OK");
                answer.setMessage(traduccion.getString("send.OK"));
            } catch (SQLException | ClassNotFoundException ex) {
                answer.setStatus("ERROR");
                if (traduccion.containsKey(ex.getMessage())) {
                    answer.setMessage(traduccion.getString(ex.getMessage()));
                } else {
                    answer.setMessage("Error: " + ex.getMessage());
                }
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
        return "Servlet to manage the sending functionalities.";
    }// </editor-fold>

}
