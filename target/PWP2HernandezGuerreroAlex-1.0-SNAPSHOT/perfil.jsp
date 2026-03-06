<%-- 
    Document   : perfil
    Created on : Feb 28, 2026, 1:06:05 PM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.AnswerTO"%>
<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="profile.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
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
            border-radius: 1.2rem;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
        }

        /* Título degradado */
        .brand-gradient {
            background: -webkit-linear-gradient(45deg, #6610f2, #0d6efd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        /* Botones personalizados con el morado corporativo */
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

        /* Estilo input focus */
        .form-control:focus {
            border-color: #6610f2;
            box-shadow: 0 0 0 0.25rem rgba(102, 16, 242, 0.25);
        }
        
        /* Ajuste visual para el input readonly */
        .form-control[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
            color: #6c757d;
        }
    </style>
</head>
<body>

    <!-- INCLUIR LA NAVBAR AQUÍ -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        
        <!-- Título principal -->
        <div class="row justify-content-center mb-4">
            <div class="col-md-8 col-lg-6 text-center">
                <h1 class="display-5 brand-gradient mb-2"><fmt:message key="profile.title" /></h1>
                <p class="text-secondary"><fmt:message key="profile.subtitle" /></p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <!-- CAJA 1: Modificar dades personals -->
                <div class="card glass-card mb-4 p-4 p-md-5 border-top border-5" style="border-top-color: #6610f2 !important;">
                    <h4 class="fw-bold mb-4" style="color: #2c3e50;">
                        <i class="bi bi-person-lines-fill me-2" style="color: #6610f2;"></i> <fmt:message key="profile.box1" />
                    </h4>
                    
                        <!-- Nom d'usuari (No modificable) -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-bold small text-secondary"><fmt:message key="profile.username" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-badge-fill text-muted"></i></span>
                                <!-- El atributo readonly bloquea la edición -->
                                <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" 
                                       value="" readonly> 
                            </div>
                            
                        </div>

                        <!-- Nom a mostrar -->
                        <div class="mb-4">
                            <label for="displayName" class="form-label fw-bold small text-secondary"><fmt:message key="register.nameMostrar" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-tag-fill"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="displayName" name="displayName" 
                                       value="" required>
                            </div>
                            <p id="missatgeName"></p>
                        </div>

                        <div class="d-grid">
                            <button id="nameBtn" type="button" class="btn btn-custom-purple shadow-sm">
                                <i class="bi bi-save me-1"></i> <fmt:message key="profile.updateNameBtn" />
                            </button>
                        </div>
                </div>

                <!-- CAJA 2: Seguretat del compte -->
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #0d6efd !important;">
                    <h4 class="fw-bold mb-4" style="color: #2c3e50;">
                        <i class="bi bi-shield-lock-fill me-2" style="color: #0d6efd;"></i> <fmt:message key="profile.box2" />
                    </h4>
                    
                        <!-- Nova contrasenya -->
                        <div class="mb-3">
                            <label for="newPassword" class="form-label fw-bold small text-secondary"><fmt:message key="profile.newPass" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-key-fill"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="newPassword" name="newPassword" 
                                       placeholder="<fmt:message key='profile.newPassPlaceholder' />" required>
                            </div>
                        </div>

                        <!-- Verifica la contrasenya -->
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label fw-bold small text-secondary"><fmt:message key="profile.verifyPass" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-check-circle-fill"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="confirmPassword" name="confirmPassword" 
                                       placeholder="<fmt:message key='profile.verifyPassPlaceholder' />" required>
                            </div>
                            <p id="missatgeResultat" class="small mt-1 mb-0 d-none">
                                    <i class="bi bi-exclamation-triangle-fill me-1 "></i>
                                </p>
                        </div>

                        <div class="d-grid">
                            <button type="button" id="btnPass" class="btn btn-dark shadow-sm" style="border-radius: 0.8rem; padding: 0.6rem;">
                                <i class="bi bi-lock-fill me-1"></i> <fmt:message key="profile.changePassBtn" />
                            </button>
                        </div>
                </div>

            </div>
        </div>

    </div>

            <!-- Bootstrap JS Bundle -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                
                loadData();
                
                function loadData() {
                    var loading = "loading";
                   
                   $.ajax({
                      type: 'GET',
                      data: {loading: loading},
                      dataType: "json",
                      url: 'Perfil',
                      success: function(resposta) {
                            if (resposta.status === "" || resposta.status === "OK") {
                                $('#username').val(resposta.user.username);
                                $('#displayName').val(resposta.user.nom);

                            } else {
                                $('#missatgeResultat')
                                    .removeClass('d-none text-success')
                                    .addClass('text-danger')
                                    .text(resposta.message);
                            }
                      },
                      error: function(jqXHR, textStatus, errorThrown) {
                          console.log(textStatus);
                      }
                   });
                }
                
                $('#btnPass').click(function() {
                   var pass1 = $('#newPassword').val();
                   var pass2 = $('#confirmPassword').val();
                   if (pass1 !== "") {
                    $.ajax({
                       type: 'POST',
                       data: {pass1: pass1, pass2: pass2},
                       dataType: "json",
                       url: 'Perfil',
                       success: function(resposta) {
                           if (resposta.status === "OK") {
                             $('#missatgeResultat')
                             .removeClass('d-none text-danger')
                             .addClass('text-success')
                             .text(resposta.message);
                           }else if(resposta.status === "ERROR") {
                             $('#missatgeResultat')
                             .removeClass('d-none text-success')
                             .addClass('text-danger')
                             .text(resposta.message);
                           } else {
                             $('#missatgeResultat')
                             .removeClass('d-none text-success')
                             .addClass('text-danger')
                             .text(resposta.message);
                           }
                           loadData();
                       },
                       error: function(jqXHR, textStatus, errorThrown) {
                           console.log(textStatus);
                       }
                    });
                   } else {
                        $('#missatgeResultat')
                        .removeClass('d-none text-success')
                        .addClass('text-danger')
                        .text("<fmt:message key='send.missingFields' />");
                   }
                });
                
                $('#nameBtn').click(function() {
                   var name = $('#displayName').val();
                   var loading = "no";
                   $.ajax({
                      type: 'GET',
                      data: {displayName: name, loading: loading},
                      dataType: "json",
                      url: 'Perfil',
                      success: function(resposta) {
                        var $msg = $('#missatgeName');
                        $msg.removeClass('d-none text-danger text-success');

                        if (resposta.status === "OK") {
                            $msg.addClass('text-success').text(resposta.message);
                        } else if (resposta.status === "nom") {
                            $msg.addClass('text-danger').text(resposta.message);
                        } else {
                            $msg.addClass('text-danger').text(resposta.message);
                        }
                        
                        loadData();
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