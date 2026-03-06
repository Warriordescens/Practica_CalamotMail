<%-- 
    Document   : welcome
    Created on : Feb 28, 2026, 11:10:32 AM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.Log"%>
<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="welcome.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        /* Mismo fondo global */
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: system-ui, -apple-system, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Tarjeta Principal Flotante (Glassmorphism) */
        .glass-card {
            background-color: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 1.5rem;
        }

        /* Animación Hover para los 3 cuadrados inferiores */
        .action-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 1.2rem;
            border: 1px solid rgba(0,0,0,0.05);
        }
        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(102, 16, 242, 0.15) !important;
            border-color: rgba(102, 16, 242, 0.3);
        }
        
        /* --- ESTILOS ESPECIALES PARA ADMINISTRADOR --- */
        .admin-card-users {
            background: linear-gradient(135deg, rgba(255, 240, 243, 0.95) 0%, rgba(255, 255, 255, 0.95) 100%);
            border-top: 4px solid #dc3545; /* Rojo peligro/admin */
        }
        .admin-card-top {
            background: linear-gradient(135deg, rgba(255, 248, 225, 0.95) 0%, rgba(255, 255, 255, 0.95) 100%);
            border-top: 4px solid #ffc107; /* Dorado/Trofeo */
        }

        /* Botones Admin */
        .btn-admin-red {
            background-color: #dc3545; border-color: #dc3545; color: white;
            border-radius: 0.8rem; padding: 0.6rem 1.2rem; font-weight: 600;
        }
        .btn-admin-red:hover { background-color: #bb2d3b; border-color: #b02a37; color: white; }

        .btn-admin-gold {
            background-color: #ffc107; border-color: #ffc107; color: #212529;
            border-radius: 0.8rem; padding: 0.6rem 1.2rem; font-weight: 600;
        }
        .btn-admin-gold:hover { background-color: #ffca2c; border-color: #ffc720; color: #000; }
        

        /* Botones personalizados con el morado corporativo */
        .btn-custom-purple {
            background-color: #6610f2;
            border-color: #6610f2;
            color: white;
            border-radius: 0.8rem;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
        }
        .btn-custom-purple:hover {
            background-color: #520dc2;
            border-color: #520dc2;
            color: white;
        }
        
        .icon-large {
            font-size: 2.5rem;
            color: #6610f2;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

    <!-- INCLUIR LA NAVBAR AQUÍ -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        
        <%
            User user = (User) session.getAttribute("usuari");
            Log log = (Log) request.getAttribute("lastLogin");
            String data;
            if (log != null) {
                data = log.getDate();
            } else {
                data = "No has iniciat sessió anteriorment.";
            }
        %>
        
        <!-- 1. Cuadro de Bienvenida Decorado -->
        <div class="row justify-content-center mb-5">
            <div class="col-12">
                <div class="card glass-card shadow-lg p-4 p-md-5 border-start border-5" style="border-left-color: #6610f2 !important;">
                    <div class="d-flex align-items-center gap-3">
                        <div class="bg-light rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                            <i class="bi bi-person-bounding-box" style="font-size: 2rem; color: #6610f2;"></i>
                        </div>
                        <div>
                            <!-- Saludo traducido + Nombre del usuario dinámico -->
                            <p class="fs-3 fw-bold mb-1" style="color: #2c3e50;">
                                <fmt:message key="welcome.hello" />, <%= user.getUsername() %>
                            </p>
                            <!-- Último acceso traducido + Fecha dinámica -->
                            <p class="text-secondary small mb-0">
                                <i class="bi bi-clock-history me-1"></i> 
                                <fmt:message key="welcome.lastAccess" /> <%= data %>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 2. Los tres cuadrados de acción -->
        <div class="row g-4">
            
            <!-- Cuadrado 1: Enviar Mail -->
            <div class="col-md-4">
                <div class="card glass-card action-card shadow-sm h-100 p-4 text-center">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <i class="bi bi-pencil-square icon-large"></i>
                        <h4 class="fw-bold mb-3"><fmt:message key="welcome.sendMail" /></h4>
                        <p class="text-muted small mb-4"><fmt:message key="welcome.sendMailDesc" /></p>
                        <a href="Enviar" class="btn btn-custom-purple mt-auto w-100 shadow-sm">
                            <i class="bi bi-send me-1"></i> <fmt:message key="welcome.composeBtn" />
                        </a>
                    </div>
                </div>
            </div>

            <!-- Cuadrado 2: Safata d'entrada -->
            <div class="col-md-4">
                <div class="card glass-card action-card shadow-sm h-100 p-4 text-center">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <i class="bi bi-inbox-fill icon-large"></i>
                        <h4 class="fw-bold mb-3"><fmt:message key="inbox" /></h4>
                        <p class="text-muted small mb-4"><fmt:message key="welcome.inboxDesc" /></p>
                        <a href="safata.jsp" class="btn btn-custom-purple mt-auto w-100 shadow-sm">
                            <i class="bi bi-envelope-open me-1"></i> <fmt:message key="welcome.viewInboxBtn" />
                        </a>
                    </div>
                </div>
            </div>

            <!-- Cuadrado 3: Enviats -->
            <div class="col-md-4">
                <div class="card glass-card action-card shadow-sm h-100 p-4 text-center">
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <i class="bi bi-send-check-fill icon-large"></i>
                        <h4 class="fw-bold mb-3"><fmt:message key="welcome.sent" /></h4>
                        <p class="text-muted small mb-4"><fmt:message key="welcome.sentDesc" /></p>
                        <a href="Enviats" class="btn btn-custom-purple mt-auto w-100 shadow-sm">
                            <i class="bi bi-clock-history me-1"></i> <fmt:message key="welcome.viewSentBtn" />
                        </a>
                    </div>
                </div>
            </div>

        </div>
                        
        <% if(user.getAdmin()) { %>
        
            <div class="row mt-5 mb-4 justify-content-center">
                <div class="col-8 text-center">
                    <hr class="text-danger opacity-25 mb-4">
                    <h4 class="fw-bold text-danger mb-0">
                        <i class="bi bi-shield-lock-fill me-2"></i><fmt:message key="welcome.admin.title" />
                    </h4>
                </div>
            </div>

            <!-- Tarjetas de Admin -->
            <div class="row g-4 justify-content-center">
                
                <!-- Gestió d'usuaris -->
                <div class="col-md-5">
                    <div class="card glass-card action-card admin-card-users shadow-sm h-100 p-4 text-center">
                        <div class="card-body d-flex flex-column align-items-center justify-content-center">
                            <!-- Icono bi-people-fill de Bootstrap Icons -->
                            <i class="bi bi-people-fill mb-3" style="font-size: 2.5rem; color: #dc3545;"></i>
                            <h4 class="fw-bold mb-3 text-dark"><fmt:message key="welcome.admin.users" /></h4>
                            <p class="text-muted small mb-4"><fmt:message key="welcome.admin.usersDesc" /></p>
                            <a href="adminGestioUsers.jsp" class="btn btn-admin-red mt-auto w-100 shadow-sm">
                                <i class="bi bi-person-lines-fill me-1"></i> <fmt:message key="welcome.admin.usersBtn" />
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Top 10 enviadors -->
                <div class="col-md-5">
                    <div class="card glass-card action-card admin-card-top shadow-sm h-100 p-4 text-center">
                        <div class="card-body d-flex flex-column align-items-center justify-content-center">
                            <!-- Icono bi-trophy-fill de Bootstrap Icons -->
                            <i class="bi bi-trophy-fill mb-3" style="font-size: 2.5rem; color: #ffc107;"></i>
                            <h4 class="fw-bold mb-3 text-dark"><fmt:message key="welcome.admin.top" /></h4>
                            <p class="text-muted small mb-4"><fmt:message key="welcome.admin.topDesc" /></p>
                            <a href="AdminTopEnviadors" class="btn btn-admin-gold mt-auto w-100 shadow-sm">
                                <i class="bi bi-bar-chart-fill me-1"></i> <fmt:message key="welcome.admin.topBtn" />
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        <% } %>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>