<%-- 
    Document   : topPlastes
    Created on : Mar 5, 2026, 7:13:07 PM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.PlastesTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="admin.top.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <style>
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

        /* Degradado especial dorado para el título */
        .brand-gradient-gold {
            background: -webkit-linear-gradient(45deg, #ffc107, #fd7e14);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        /* --- ESTILOS DE MEDALLAS --- */
        .pos-badge {
            width: 42px;
            height: 42px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-weight: 800;
            font-size: 1.2rem;
            transition: transform 0.2s ease;
        }
        
        /* 1º Oro */
        .medal-gold {
            background: linear-gradient(135deg, #FFD700 0%, #DAA520 100%);
            color: white;
            box-shadow: 0 4px 10px rgba(218, 165, 32, 0.4);
            border: 2px solid #fff;
        }
        /* 2º Plata */
        .medal-silver {
            background: linear-gradient(135deg, #E0E0E0 0%, #B8B8B8 100%);
            color: #495057;
            box-shadow: 0 4px 10px rgba(184, 184, 184, 0.4);
            border: 2px solid #fff;
        }
        /* 3º Bronce */
        .medal-bronze {
            background: linear-gradient(135deg, #CD7F32 0%, #A0522D 100%);
            color: white;
            box-shadow: 0 4px 10px rgba(205, 127, 50, 0.4);
            border: 2px solid #fff;
        }
        /* Del 4º al 10º */
        .medal-standard {
            background-color: #f8f9fa;
            color: #6c757d;
            border: 1px solid #dee2e6;
            font-size: 1rem;
        }

        /* Efecto hover en la fila */
        .table-hover tbody tr:hover .pos-badge {
            transform: scale(1.15);
        }

        .table-scroll-container {
            border-radius: 0.5rem;
            border: 1px solid #e9ecef;
            overflow: hidden;
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <%
        List<PlastesTO> plastes = (List<PlastesTO>) request.getAttribute("mesPesats");
        
    %>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #ffc107 !important;">
                    
                    <!-- CABECERA: Título con trofeo -->
                    <div class="text-center mb-5">
                        <i class="bi bi-trophy-fill mb-2" style="font-size: 3.5rem; color: #ffc107;"></i>
                        <h2 class="display-6 brand-gradient-gold mb-1"><fmt:message key="admin.top.title" /></h2>
                    </div>

                    <!-- TABLA DE RANKING -->
                    <div class="table-scroll-container shadow-sm">
                        <table class="table table-hover align-middle mb-0 fs-5">
                            <thead>
                                <tr class="table-light">
                                    <th scope="col" class="text-secondary text-center" style="width: 20%;"><fmt:message key="admin.top.col.position" /></th>
                                    <!-- Reutilizamos traducción existente -->
                                    <th scope="col" class="text-secondary" style="width: 50%;"><fmt:message key="admin.users.col.username" /></th>
                                    <th scope="col" class="text-secondary text-center" style="width: 30%;"><fmt:message key="admin.top.col.messages" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    int top = 1;
                                    for(PlastesTO p: plastes) {
                                        String claseMedalla = "medal-standard";
                                        String iconoUsuario = "bi-person-fill"; 
                                        
                                        if(top == 1) {
                                            claseMedalla = "medal-gold";
                                            iconoUsuario = "bi-trophy-fill text-warning";
                                        } else if(top == 2) {
                                            claseMedalla = "medal-silver";
                                            iconoUsuario = "bi-award-fill text-secondary";
                                        } else if(top == 3) {
                                            claseMedalla = "medal-bronze";
                                            iconoUsuario = "bi-award-fill" + "\" style=\"color: #cd7f32;";
                                        }
                                %>
                                
                                    <tr class="<%= top <= 3 ? "bg-light" : "" %>">
                                        
                                        <td class="text-center py-3">
                                            <span class="pos-badge <%= claseMedalla %> shadow-sm">
                                                <%= top %>
                                            </span>
                                        </td>
                                        
                                        <td class="py-3">
                                            <div class="d-flex align-items-center">
                                                <i class="bi <%= iconoUsuario %> me-3 fs-4"></i>
                                                <span class="<%= top <= 3 ? "fw-bold text-dark fs-4" : "fw-medium text-secondary" %>">
                                                    <%= p.getUsername() %>
                                                </span>
                                            </div>
                                        </td>
                                        
                                        <td class="text-center py-3">
                                            <span class="badge rounded-pill fs-6 <%= top <= 3 ? "bg-primary" : "bg-secondary bg-opacity-75" %>">
                                                <i class="bi bi-send-fill me-1"></i> <%= p.getMessageNumber() %>
                                            </span>
                                        </td>
                                        
                                    </tr>

                                <% 
                                    top++;
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Botón para volver -->
                    <div class="text-center mt-5">
                        <a href="Welcome" class="btn btn-light border shadow-sm rounded-pill px-4 fw-bold text-secondary">
                            <i class="bi bi-arrow-left me-2"></i> Tornar a l'Inici
                        </a>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>