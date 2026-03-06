<%-- 
    Document   : index
    Created on : Jan 30, 2026, 3:34:29 PM
    Author     : admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="index.title"/></title>
    
    <!-- Bootstrap CSS 5.3 [3] -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    
    <!-- Bootstrap Icons [4] -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        /* FONDO: Degradado moderno y suave */
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        /* TÍTULO: Efecto de texto con degradado */
        .brand-gradient {
            background: -webkit-linear-gradient(45deg, #6610f2, #0d6efd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        /* TARJETA PRINCIPAL: Estilo flotante */
        .main-card {
            background-color: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 1.5rem; /* Bordes muy redondeados */
        }

        /* BOTONES DE ACCIÓN: Grandes y llamativos */
        .btn-action {
            padding: 1rem;
            border-radius: 1rem;
            font-weight: 600;
            transition: transform 0.2s ease-in-out;
        }
        .btn-action:hover {
            transform: scale(1.03);
        }
        
        /* Icono decorativo del título */
        .logo-icon {
            color: #6610f2;
            font-size: 2.5rem;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-7">
                
                <!-- TARJETA PRINCIPAL CONTENEDORA -->
                <div class="card main-card shadow-lg p-4 p-md-5">
                    
                    <%@include file="WEB-INF/jspf/languages.jspf" %>

                    <!-- 2. LOGO Y MARCA -->
                    <div class="text-center mb-4">
                        <div class="mb-2">
                            <!-- Icono moderno "envelope-at" [5] -->
                            <i class="bi bi-envelope-at-fill logo-icon"></i>
                        </div>
                        <h1 class="display-4 brand-gradient">CalamotMail</h1>
                        <p class="text-muted fs-5"><fmt:message key="index.subtitle"/></p>
                    </div>

                    <!-- 3. CONTENIDO DE BIENVENIDA (Estilizado) -->
                    <div class="alert alert-light border-0 bg-light rounded-4 mb-4 text-center">
                        <h5 class="fw-bold text-dark mb-3"><fmt:message key="index.h5"/></h5>
                        <p class="text-secondary small mb-0 lh-lg">
                            <fmt:message key="index.description"/>
                        </p>
                    </div>

                    <div class="text-center text-muted fst-italic mb-4 small">
                        <i class="bi bi-stars text-warning me-1"></i><fmt:message key="index.i"/>
                    </div>

                    <!-- 4. ACCIONES (Grid moderna) -->
                    <div class="row g-3">
                        <!-- Botón Registro -->
                        <div class="col-sm-6">
                            <a href="register.jsp" class="btn btn-outline-dark w-100 btn-action d-flex flex-column align-items-center justify-content-center h-100 gap-2">
                                <!-- Icono persona [6] -->
                                <i class="bi bi-person-badge fs-3"></i>
                                <span><fmt:message key="register"/></span>
                            </a>
                        </div>
                        
                        <!-- Botón Login -->
                        <div class="col-sm-6">
                            <a href="login.jsp" class="btn btn-primary w-100 btn-action d-flex flex-column align-items-center justify-content-center h-100 gap-2" style="background-color: #6610f2; border-color: #6610f2;">
                                <!-- Icono login [7] -->
                                <i class="bi bi-box-arrow-in-right fs-3"></i>
                                <span><fmt:message key="login"/></span>
                            </a>
                        </div>
                    </div>

                    <!-- FOOTER INTERNO -->
                    <div class="mt-5 text-center border-top pt-3">
                        <small class="text-muted" style="font-size: 0.7rem;">
                            &copy; 2025 CalamotMail &bull; <fmt:message key="index.footer"/>
                        </small>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle [3] -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
