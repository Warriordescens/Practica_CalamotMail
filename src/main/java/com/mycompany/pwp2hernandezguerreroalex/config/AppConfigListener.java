/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package com.mycompany.pwp2hernandezguerreroalex.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Web application lifecycle listener.
 *
 * @author admin
 */
@WebListener
public class AppConfigListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        context.setInitParameter("javax.servlet.jsp.jstl.fmt.localizationContext", "com.mycompany.pwp2hernandezguerreroalex.i18n.messages");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
