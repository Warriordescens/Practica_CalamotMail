/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.filter;

import com.mycompany.pwp2hernandezguerreroalex.model.User;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        
        String uri = httpRequest.getRequestURI();
        if (!uri.startsWith(httpRequest.getContextPath() + "/login") && !uri.startsWith(httpRequest.getContextPath() + "/Login") && 
                !uri.equals(httpRequest.getContextPath() + "/") && !uri.startsWith(httpRequest.getContextPath() + "/index") && 
                !uri.startsWith(httpRequest.getContextPath() + "/register")&& !uri.startsWith(httpRequest.getContextPath() + "/Register")) {
            
            if (session == null || session.getAttribute("usuari") == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
                return;
            } else {
                User u = (User) session.getAttribute("usuari");
                if (!u.getAdmin() && (uri.startsWith(httpRequest.getContextPath() + "/admin") || uri.startsWith(httpRequest.getContextPath() + "/Admin"))) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/Welcome");
                return;
            }
            }
            
        }
        chain.doFilter(request, response);
    }

}
