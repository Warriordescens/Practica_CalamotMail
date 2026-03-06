<%-- 
    Document   : enviar
    Created on : Mar 1, 2026, 11:28:18 AM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="send.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

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

        .brand-gradient {
            background: -webkit-linear-gradient(45deg, #6610f2, #0d6efd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        .form-control:focus, .form-select:focus {
            border-color: #6610f2;
            box-shadow: 0 0 0 0.25rem rgba(102, 16, 242, 0.25);
        }

        .btn-custom-purple {
            background-color: #6610f2;
            border-color: #6610f2;
            color: white;
            border-radius: 0.8rem;
            padding: 0.8rem 1.2rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-custom-purple:hover {
            background-color: #520dc2;
            border-color: #520dc2;
            color: white;
            transform: translateY(-2px);
        }
        
        textarea {
            resize: vertical; /* Permite cambiar el tamaño solo hacia abajo */
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <!-- Lógica Java para recoger datos del Servlet -->
    <%
        // Aquí recoges la lista enviada por el Servlet. Cambia "Object" por tu clase "Usuario" real.
        List<User> llistaUsuaris = (List<User>) request.getAttribute("llistaContactes");
        
        // Variables para los mensajes de error/éxito del final
        String errorMsg = (String) request.getAttribute("errorEnviament");
        String successMsg = (String) request.getAttribute("exitEnviament");
    %>

    <!-- CONTINGUT PRINCIPAL -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-7">
                
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #6610f2 !important;">
                    
                    <!-- Títol -->
                    <div class="text-center mb-4">
                        <h2 class="display-6 brand-gradient mb-2">
                            <i class="bi bi-pencil-square me-2" style="color: #6610f2;"></i><fmt:message key="send.title" />
                        </h2>
                        <p class="text-secondary"><fmt:message key="send.subtitle" /></p>
                    </div>

                    <!-- Formulari -->
                    <form>
                        
                        <!-- 1. Receptor -->
                        <div class="mb-4">
                            <label for="receptor" class="form-label fw-bold small text-secondary"><fmt:message key="send.receiver" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-lines-fill"></i></span>
                                <select class="form-select border-start-0 ps-0" id="receptor" name="receptor" required>
                                    <option value="" selected disabled><fmt:message key="send.selectReceiver" /></option>
                                    
                                    <% 
                                        if (llistaUsuaris == null || llistaUsuaris.isEmpty()) { 
                                    %>
                                            <option value="" disabled><fmt:message key="send.noContacts" /></option>
                                    <% 
                                        } else {
                                            for(User u : llistaUsuaris) {
                                    %>
                                                <option value="<%= u.getUsername() %>"><%= u.getUsername() + "(" + u.getNom() + ")" %></option>
                                    <% 
                                            } 
                                        } 
                                    %>
                                </select>
                            </div>
                        </div>

                        <!-- 2. Assumpte -->
                        <div class="mb-4">
                            <label for="assumpte" class="form-label fw-bold small text-secondary"
                                   ><fmt:message key="send.subject" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-chat-left-text-fill"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="assumpte" name="assumpte" 
                                       placeholder="<fmt:message key='send.subjectPlaceholder' />" required maxlength="100"
                                       <% 
                                        if (llistaUsuaris == null || llistaUsuaris.isEmpty()) { 
                                    %> disabled <% } %>
                                       >
                            </div>
                        </div>

                        <!-- 3. Missatge (Textarea grande) -->
                        <div class="mb-4">
                            <label for="missatge" class="form-label fw-bold small text-secondary"><fmt:message key="send.message" /></label>
                            <textarea class="form-control" id="missatge" name="missatge" rows="7" 
                                      placeholder="<fmt:message key='send.messagePlaceholder' />" required
                                      <% 
                                        if (llistaUsuaris == null || llistaUsuaris.isEmpty()) { 
                                    %> disabled <% } %>
                                      ></textarea>
                        </div>

                        <!-- Botó Enviar -->
                        <div class="d-grid mt-4">
                            <button id="btnEnviar" type="button" class="btn btn-custom-purple shadow-sm">
                                <i class="bi bi-send-fill me-2"></i><fmt:message key="send.button" />
                            </button>
                        </div>

                   </form>

                    <!-- ESPACIO PARA MENSAJES DE ESTADO (Error o Éxito) -->
                    <div class="mt-4">
                        <div id="containerResultat" class="alert d-none d-flex align-items-center mb-0" role="alert">
                                <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                                <p id="missatgeResultat"><%= successMsg %></p>
                            </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#btnEnviar').click(function() {
                   var receptor = $('#receptor').val();
                   var assumpte = $('#assumpte').val();
                   var missatge = $('#missatge').val();
                   
                    $.ajax({
                       type: 'POST',
                       data: {receptor: receptor, assumpte: assumpte, missatge: missatge},
                       dataType: "json",
                       url: 'Enviar',
                       success: function(resposta) {
                           if (resposta.status === "OK") {
                             $('#containerResultat')
                             .removeClass('d-none alert-danger')
                             .addClass('alert-success');
                             $('#missatgeResultat')
                             .text(resposta.message);
                           } else {
                             $('#containerResultat')
                             .removeClass('d-none alert-success')
                             .addClass('alert-danger');
                             $('#missatgeResultat')
                             .text(resposta.message);
                           }
                       },
                       error: function(jqXHR, textStatus, errorThrown) {
                           console.log(textStatus);
                       }
                    });
                });
            });
        </script>
</body>
</html>