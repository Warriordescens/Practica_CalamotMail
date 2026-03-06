<%-- 
    Document   : adminModificarUser
    Created on : Mar 4, 2026, 1:39:29 PM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="admin.edit.title" /></title>
    
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

        .brand-gradient {
            background: -webkit-linear-gradient(45deg, #0d6efd, #6610f2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
        }

        /* Ajuste visual para el input readonly */
        .form-control[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
            color: #6c757d;
            font-weight: 500;
        }

        /* Botones */
        .btn-custom-blue {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: white;
            border-radius: 0.8rem;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-custom-blue:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
            color: white;
            transform: translateY(-2px);
        }

        .btn-custom-light {
            background-color: #f8f9fa;
            border-color: #dee2e6;
            color: #495057;
            border-radius: 0.8rem;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-custom-light:hover {
            background-color: #e2e6ea;
            color: #212529;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #0d6efd !important;">
                    
                    <!-- CABECERA -->
                    <div class="text-center mb-4">
                        <i class="bi bi-pencil-square text-primary mb-2" style="font-size: 2.5rem;"></i>
                        <h2 class="display-6 brand-gradient mb-0"><fmt:message key="admin.edit.title" /></h2>
                        <p class="text-secondary mt-1"><fmt:message key="admin.edit.subtitle" /></p>
                    </div>
                        
                        <!-- El campo oculto o readonly enviará el ID para que el backend sepa a quién actualizar -->
                        <input type="hidden" name="idUsuari" value="1">

                        <!-- 1. Nom d'usuari (Bloqueado) -->
                        <div class="mb-4">
                            <label for="username" class="form-label fw-bold small text-secondary"><fmt:message key="admin.edit.username" /></label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-badge-fill text-muted"></i></span>
                                <!-- Atributo readonly para que no se pueda modificar -->
                                <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" 
                                        readonly>
                            </div>
                        </div>

                        <!-- 2. Nom a mostrar -->
                        <div class="mb-4">
                            <label for="displayName" class="form-label fw-bold small text-secondary"><fmt:message key="register.nameMostrar" /></label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-fill text-primary"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="displayName" name="displayName" 
                                        required>
                            </div>
                        </div>

                        <!-- 3. Tipus d'usuari (Desplegable) -->
                        <div class="mb-4">
                            <label for="userType" class="form-label fw-bold small text-secondary"><fmt:message key="admin.edit.type" /></label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-shield-lock-fill text-danger"></i></span>
                                <select class="form-select border-start-0 ps-0" id="userType" name="userType" required>
                                    <!-- Lógica para que se quede seleccionado el que ya tiene el usuario -->
                                    <option id="user" value="user">
                                        <fmt:message key="admin.edit.type.user" />
                                    </option>
                                    <option id="admin" value="admin">
                                        <fmt:message key="admin.edit.type.admin" />
                                    </option>
                                </select>
                            </div>
                        </div>

                        <!-- 4. Nova Contrasenya -->
                        <div class="mb-5">
                            <label for="newPassword" class="form-label fw-bold small text-secondary"><fmt:message key="admin.edit.newPass" /></label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-key-fill text-warning"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="newPassword" name="newPassword" 
                                       placeholder="<fmt:message key='admin.edit.newPassPlaceholder' />">
                            </div>
                        </div>
                            
                        <p id="missatgeResultat" class="small mt-1 mb-0 d-none">
                            <i class="bi bi-exclamation-triangle-fill me-1 "></i>
                        </p>

                        <!-- BOTONES: Tornar y Guardar Canvis -->
                        <div class="d-flex justify-content-between gap-3">
                            <!-- Botón Tornar -->
                            <a href="adminGestioUsers.jsp" class="btn btn-custom-light w-50 shadow-sm d-flex justify-content-center align-items-center">
                                <i class="bi bi-arrow-left-circle me-2"></i> <fmt:message key="admin.edit.backBtn" />
                            </a>
                            
                            <!-- Botón Guardar -->
                            <button id="btnModif" type="button" class="btn btn-custom-blue w-50 shadow-sm d-flex justify-content-center align-items-center">
                                <i class="bi bi-save-fill me-2"></i> <fmt:message key="admin.edit.saveBtn" />
                            </button>
                        </div>


                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                
                loadData();
                
                function loadData() {
                    var userModif = "${userModif}";
                   $.ajax({
                      type: 'GET',
                      data: {userModif: userModif},
                      dataType: "json",
                      url: 'AdminModificarUser',
                      success: function(resposta) {
                            $('#username').val(resposta.user.username);
                            $('#displayName').val(resposta.user.nom);
                            var valorADefinir = (resposta.user.admin === true) ? "admin" : "user";
                            $('#userType').val(valorADefinir);
                            
                      },
                      error: function(jqXHR, textStatus, errorThrown) {
                          console.log(textStatus);
                      }
                   });
                }
                
                $('#btnModif').click(function() {
                   var pass = $('#newPassword').val();
                   var username = $('#username').val();
                   var name = $('#displayName').val();
                   var type = $('#userType').val() === 'admin'? true : false;
                    $.ajax({
                       type: 'POST',
                       data: {pass: pass, name: name, type:type, username: username},
                       dataType: "json",
                       url: 'AdminModificarUser',
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
                });
        });
        </script>
</body>
</html>
