
<%-- 
    Document   : adminNewUser
    Created on : Mar 4, 2026, 1:48:39 PM
    Author     : admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="admin.create.title" /></title>
    
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

        /* Usamos un degradado verde para indicar "Creación/Alta" */
        .brand-gradient {
            background: -webkit-linear-gradient(45deg, #198754, #20c997);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 800;
        }

        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
        }

        /* Botón de creación (Verde Success) */
        .btn-custom-green {
            background-color: #198754;
            border-color: #198754;
            color: white;
            border-radius: 0.8rem;
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.2s;
        }
        .btn-custom-green:hover {
            background-color: #157347;
            border-color: #146c43;
            color: white;
            transform: translateY(-2px);
        }

        /* Botón de volver (Gris claro) */
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
                
                <!-- Borde superior en verde (#198754) para la temática de Alta -->
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #198754 !important;">
                    
                    <!-- CABECERA -->
                    <div class="text-center mb-4">
                        <i class="bi bi-person-plus-fill text-success mb-2" style="font-size: 2.5rem;"></i>
                        <h2 class="display-6 brand-gradient mb-0"><fmt:message key="admin.create.title" /></h2>
                        <p class="text-secondary mt-1"><fmt:message key="admin.create.subtitle" /></p>
                    </div>

                        <!-- 1. Nom d'usuari (Reaprovechando llave de gestioUsuaris) -->
                        <div class="mb-4">
                            <label for="username" class="form-label fw-bold small text-secondary">
                                <fmt:message key="admin.users.col.username" />
                            </label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-badge-fill text-secondary"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" placeholder="Ex: jgarcia" required>
                            </div>
                            <p id="missatgeUsername" class="small mt-1 mb-0 d-none">
                                <i class="bi bi-exclamation-circle-fill me-1"></i>
                            </p>
                        </div>
                            

                        <!-- 2. Nom a mostrar (Reaprovechando llave de gestioUsuaris) -->
                        <div class="mb-4">
                            <label for="displayName" class="form-label fw-bold small text-secondary">
                                <fmt:message key="admin.users.col.displayName" />
                            </label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-fill text-success"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="displayName" name="displayName" placeholder="Ex: Joan Garcia" required>
                            </div>
                        </div>

                        <!-- 3. Contrasenya (Llave nueva) -->
                        <div class="mb-4">
                            <label for="password" class="form-label fw-bold small text-secondary">
                                <fmt:message key="admin.create.password" />
                            </label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-key-fill text-warning"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="password" name="password" placeholder="**********" required>
                            </div>
                        </div>

                        <!-- 4. Tipus d'usuari (Reaprovechando llaves de adminModificarUser) -->
                        <div class="mb-5">
                            <label for="userType" class="form-label fw-bold small text-secondary">
                                <fmt:message key="admin.edit.type" />
                            </label>
                            <div class="input-group shadow-sm">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-shield-lock-fill text-danger"></i></span>
                                <select class="form-select border-start-0 ps-0" id="userType" name="userType" required>
                                    <option value="user" selected>
                                        <fmt:message key="admin.edit.type.user" />
                                    </option>
                                    <option value="admin">
                                        <fmt:message key="admin.edit.type.admin" />
                                    </option>
                                </select>
                            </div>
                        </div>
                        <p id="missatgeResultat" class="small mt-1 mb-0 d-none">
                            <i class="bi bi-exclamation-triangle-fill me-1 "></i>
                        </p>

                        <!-- BOTONES: Tornar y Crear -->
                        <div class="d-flex justify-content-between gap-3">
                            <!-- Botón Tornar (Reaprovechando llave) apuntando a gestioUsuaris.jsp -->
                            <a href="adminGestioUsers.jsp" class="btn btn-custom-light w-50 shadow-sm d-flex justify-content-center align-items-center">
                                <i class="bi bi-arrow-left-circle me-2"></i> <fmt:message key="admin.edit.backBtn" />
                            </a>

                            <!-- Botón Crear (Reaprovechando la llave del título "Crear usuari") -->
                            <button id="btnCreate" type="button" class="btn btn-custom-green w-50 shadow-sm d-flex justify-content-center align-items-center">
                                <i class="bi bi-check-circle-fill me-2"></i> <fmt:message key="admin.create.title" />
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
                $('#btnCreate').click(function() {
                   var username = $('#username').val();
                   var name = $('#displayName').val();
                   var pass = $('#password').val();
                   var type = $('#userType').val() === 'admin'? true : false;
                   
                   $.ajax({
                      type: 'POST',
                      data: {username: username, name: name, pass: pass, type: type},
                      dataType: "json",
                      url: 'AdminCreateUser',
                      success: function(resposta) {
                          if (resposta.status === "OK") {
                            $('#missatgeResultat')
                            .removeClass('d-none text-danger')
                            .addClass('text-success')
                            .text(resposta.message);
                            $('#missatgeUsername')
                            .addClass('d-none');
                          }else if(resposta.status === "USERNAME") {
                            $('#missatgeUsername')
                            .removeClass('d-none text-danger')
                            .addClass('text-danger')
                            .text(resposta.message);
                            $('#missatgeResultat')
                            .addClass('d-none');
                          } else {
                            $('#missatgeResultat')
                            .removeClass('d-none text-success')
                            .addClass('text-danger')
                            .text(resposta.message);
                            $('#missatgeUsername')
                            .addClass('d-none');
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
