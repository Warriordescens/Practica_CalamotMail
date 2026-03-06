<%-- 
    Document   : enviats
    Created on : Mar 3, 2026, 10:39:55 AM
    Author     : admin
--%>

<%@page import="java.time.format.FormatStyle"%>
<%@page import="java.util.Locale"%>
<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="sent.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <style>
        /* Estilos base (Fondo y tarjetas de cristal) */
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: system-ui, -apple-system, sans-serif;
            margin: 0;
            padding: 0;
        }

        .glass-card {
            background-color: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 1.2rem;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
        }

        .brand-gradient {
            background: -webkit-linear-gradient(45deg, #6610f2, #0d6efd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        /* Contenedor grande para la tabla scrolleable */
        .table-scroll-container {
            max-height: 65vh; 
            overflow-y: auto;  
            border-radius: 0.5rem;
            border: 1px solid #e9ecef;
        }

        .table-scroll-container thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }
        
        /* Píldora difuminada para el receptor */
        .receiver-badge {
            background-color: rgba(102, 16, 242, 0.08); /* Fondo morado muy difuminado */
            color: #520dc2; /* Texto morado oscuro */
            border: 1px solid rgba(102, 16, 242, 0.2); /* Borde sutil */
            padding: 0.4rem 0.8rem;
            border-radius: 50rem; /* Forma de píldora redondita */
            font-size: 0.95rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.4rem; /* Espacio entre el icono y el texto */
            box-shadow: 0 2px 4px rgba(0,0,0,0.02); /* Relieve muy suave */
            transition: all 0.2s ease-in-out;
        }
        .receiver-badge:hover {
            background-color: rgba(102, 16, 242, 0.15); /* Se oscurece un pelín al pasar el ratón */
            transform: translateY(-1px);
        }

        /* Ajustes de botones de acción */
        .btn-action-icon {
            padding: 0.3rem 0.5rem;
            border-radius: 0.5rem;
            transition: transform 0.2s;
        }
        .btn-action-icon:hover {
            transform: scale(1.1);
        }
        .btn-view {
            color: #6610f2;
            background-color: rgba(102, 16, 242, 0.1);
        }
        .btn-view:hover {
            background-color: #6610f2;
            color: white;
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <%
        List<Message> llistaMissatges = (List<Message>) request.getAttribute("missatgesEnviats");
        
        Locale localeActiu = (Locale) session.getAttribute("currentLocale");
        DateTimeFormatter formatter = DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM).withLocale(localeActiu);
        
    %>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-xl-11">
                
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #6610f2 !important;">
                    
                    <!-- Título -->
                    <div class="mb-4 d-flex align-items-center gap-3">
                        <i class="bi bi-send-check-fill text-primary" style="font-size: 2.5rem; color: #6610f2 !important;"></i>
                        <div>
                            <h2 class="display-6 brand-gradient mb-0"><fmt:message key="sent.title" /></h2>
                            <p class="text-secondary mb-0"><fmt:message key="sent.subtitle" /></p>
                        </div>
                    </div>

                    <% 
                        if (llistaMissatges == null || llistaMissatges.isEmpty()) { 
                    %>
                        <div class="alert alert-light border border-secondary text-center py-5 rounded-4 mt-3">
                            <i class="bi bi-send-slash text-muted" style="font-size: 3rem;"></i>
                            <h5 class="mt-3 text-secondary fw-bold"><fmt:message key="sent.empty" /></h5>
                        </div>
                    <% 
                        } else { 
                    %>
                        <div class="table-scroll-container mt-2 shadow-sm">
                            <table class="table table-hover align-middle mb-0 fs-5">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-secondary" style="width: 30%;"><fmt:message key="sent.col.receiver" /></th>
                                        <th scope="col" class="text-secondary" style="width: 45%;"><fmt:message key="sent.col.subject" /></th>
                                        <th scope="col" class="text-secondary" style="width: 25%;"><fmt:message key="sent.col.date" /></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        for(Message m: llistaMissatges) {
                                    %>
                                    
                                        <tr>
                                            <td class="py-3">
                                                <span class="receiver-badge">
                                                    <i class="bi bi-person-fill"></i>
                                                    <%= m.getReceptor().getUsername() %>
                                                </span>
                                            </td>
                                            <td class="py-3">
                                                <%= m.getSubject() %>
                                            </td>
                                            <td class="py-3 text-muted small">
                                                <%= m.getRawFecha().format(formatter) %>
                                            </td>
                                        </tr>

                                    <% 
                                        } 
                                    %>
                                </tbody>
                            </table>
                        </div>
                    <% 
                        } 
                    %>
                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
