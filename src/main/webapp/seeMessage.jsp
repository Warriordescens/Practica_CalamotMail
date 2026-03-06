<%-- 
    Document   : seeMessage
    Created on : Mar 1, 2026, 9:20:28 PM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="view.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <style>
        /* Estilos base consistentes */
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

        /* Botones personalizados */
        .btn-custom-purple {
            background-color: #6610f2;
            border-color: #6610f2;
            color: white;
            border-radius: 0.8rem;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-custom-purple:hover {
            background-color: #520dc2;
            border-color: #520dc2;
            color: white;
            transform: translateY(-2px);
        }

        /* Área de contenido del mensaje */
        .message-content {
            background-color: rgba(248, 249, 250, 0.8);
            border-radius: 0.8rem;
            padding: 2rem;
            min-height: 250px;
            white-space: pre-wrap; /* Mantiene los saltos de línea originales del texto */
            border: 1px solid #e9ecef;
            color: #2c3e50;
            line-height: 1.6;
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <!-- Lógica Java para recoger el mensaje del Servlet -->
    <%
        Message m = (Message) request.getAttribute("message");
    %>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 col-xl-8">
                
                <!-- Titulillo superior -->
                <div class="text-center mb-4">
                    <h2 class="display-6 brand-gradient mb-0">
                        <i class="bi bi-envelope-open me-2" style="color: #6610f2;"></i><fmt:message key="view.title" />
                    </h2>
                </div>

                <!-- Caja principal del mensaje -->
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #6610f2 !important;">
                    
                    <!-- 1. Asunto -->
                    <h3 class="fw-bold text-dark mb-2"><%= m.getSubject() %></h3>
                    
                    <!-- 2. Meta info: Emisor y Fecha en texto pequeño -->
                    <div class="d-flex flex-wrap align-items-center text-muted small border-bottom pb-3 mb-4 gap-2">
                        <span class="d-flex align-items-center bg-light px-2 py-1 rounded border">
                            <i class="bi bi-person-circle me-2 text-primary"></i> 
                            <fmt:message key="view.from" />: <strong class="ms-1 text-dark"><%= m.getEmisor().getNom() %>(<%= m.getEmisor().getUsername() %>)</strong>
                        </span>
                        <span class="text-black-50 fw-bold">|</span>
                        <span class="d-flex align-items-center bg-light px-2 py-1 rounded border">
                            <i class="bi bi-calendar-event me-2 text-primary"></i> 
                            <fmt:message key="view.date" />: <strong class="ms-1 text-dark"><%= m.getFecha() %></strong>
                        </span>
                    </div>

                    <!-- 3. Contenido del mensaje -->
                    <div class="message-content shadow-sm mb-4 fs-5"><%= m.getContent() %></div>

                    <!-- 4. Botón Volver -->
                    <div class="d-flex justify-content-start">
                        <a href="safata.jsp" class="btn btn-custom-purple shadow-sm">
                            <i class="bi bi-arrow-left-circle-fill me-2"></i><fmt:message key="view.backBtn" />
                        </a>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>
