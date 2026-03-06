<%-- 
    Document   : test
    Created on : Feb 6, 2026, 3:13:36 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="login.title"/></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        /* Estils globals coherents amb la resta de l'app */
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: system-ui, -apple-system, sans-serif;
        }

        .main-card {
            background-color: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 1.5rem;
        }

        .brand-text {
            background: -webkit-linear-gradient(45deg, #6610f2, #0d6efd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        /* Estil input focus */
        .form-control:focus {
            border-color: #6610f2;
            box-shadow: 0 0 0 0.25rem rgba(102, 16, 242, 0.25);
        }

        /* Botó Login personalitzat */
        .btn-login {
            background-color: #6610f2;
            border-color: #6610f2;
            padding: 0.8rem;
            font-weight: 600;
            border-radius: 0.8rem;
            transition: all 0.2s;
        }
        .btn-login:hover {
            background-color: #520dc2;
            border-color: #520dc2;
            transform: translateY(-1px);
        }
        
        /* Ajustos per al selector d'idiomes importat */
        .lang-container {
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: flex-end;
        }
    </style>
</head>
<body>

    <% 
        String credencialsInvalides = (String) request.getAttribute("message"); 
    %>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5 col-xl-4">
                
                <div class="card main-card shadow-lg p-4">
                    
                    <!-- 1. INCLUSIÓ DELS IDIOMES -->
                    <!-- Assegura't que el div del teu jspf tingui les classes adequades o estigui net -->
                    <div class="lang-container">
                        <%@include file="WEB-INF/jspf/languages.jspf" %>
                    </div>

                    <!-- 2. CAPÇALERA -->
                    <div class="text-center mb-4">
                        <a href="index.jsp" class="text-decoration-none">
                            <i class="bi bi-envelope-at-fill" style="font-size: 2.5rem; color: #6610f2;"></i>
                        </a>
                        <h2 class="brand-text mt-2"><fmt:message key="login.welcome"/></h2>
                        <p class="text-muted small"><fmt:message key="login.exp"/></p>
                    </div>

                    <!-- 3. FORMULARI DE LOGIN -->
                    <form action="Login" method="POST">
                        
                        <!-- Nom d'usuari -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-bold small text-secondary"><fmt:message key="username"/></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-fill"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" 
                                       placeholder="El teu usuari" required autofocus>
                            </div>
                        </div>

                        <!-- Contrasenya -->
                        <div class="mb-4">
                            <div class="d-flex justify-content-between">
                                <label for="password" class="form-label fw-bold small text-secondary"><fmt:message key="pass"/></label>
                            </div>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-key-fill"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="password" name="password" 
                                       placeholder="••••••••" required>
                            </div>

                            <% if (credencialsInvalides != null) { %>
                                <div class="d-flex align-items-center mt-2 text-danger small animate-fade-in">
                                    <i class="bi bi-exclamation-octagon-fill me-2"></i>
                                    <span><fmt:message key= "<%= credencialsInvalides %>" /></span>
                                </div>
                            <% } %>
                        </div>
                        <!-- Botó Submit -->
                        <div class="d-grid mb-4">
                            <button type="submit" class="btn btn-primary btn-login text-white shadow-sm">
                                <i class="bi bi-box-arrow-in-right me-2"></i> <fmt:message key="login"/>
                            </button>
                        </div>

                        <div class="text-center border-top pt-3">
                            <small class="text-muted"><fmt:message key="login.noAccount"/> 
                                <a href="register.jsp" class="text-decoration-none fw-bold" style="color: #6610f2;"><fmt:message key="register"/></a>
                            </small>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
