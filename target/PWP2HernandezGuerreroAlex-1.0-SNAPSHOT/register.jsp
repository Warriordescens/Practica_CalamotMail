<%-- 
    Document   : register
    Created on : Feb 7, 2026, 6:29:22 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - Registre</title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        /* Mismo fondo y estilos que la página de inicio para consistencia */
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

        /* Estilo para los inputs */
        .form-control:focus {
            border-color: #6610f2;
            box-shadow: 0 0 0 0.25rem rgba(102, 16, 242, 0.25);
        }

        .btn-register {
            background-color: #6610f2;
            border-color: #6610f2;
            padding: 0.8rem;
            font-weight: 600;
            border-radius: 0.8rem;
        }
        .btn-register:hover {
            background-color: #520dc2;
            border-color: #520dc2;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 col-xl-5">
                
                <div class="card main-card shadow-lg p-4">
                    
                    <%@include file="WEB-INF/jspf/languages.jspf" %>
                    
                    <!-- Cabecera del formulario -->
                    <div class="text-center mb-4">
                        <a href="index.jsp" class="text-decoration-none">
                            <i class="bi bi-envelope-at-fill" style="font-size: 2rem; color: #6610f2;"></i>
                        </a>
                        <h2 class="brand-text mt-2"><fmt:message key="createAcc" /></h2>
                        <p class="text-muted small"><fmt:message key="uneixte" /></p>
                    </div>

                        
                        <!-- 1. NOM D'USUARI (Max 10) -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-bold small text-secondary"><fmt:message key="username" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person-fill"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="username" name="username" 
                                       placeholder="Ex: jgarcia" maxlength="10" required>
                            </div>
                            
                        <!-- Lógica de error USUARIO -->
                        <p id="missatgeUsername" class="small mt-1 mb-0 d-none">
                                <i class="bi bi-exclamation-circle-fill me-1"></i>
                            </p>
                        </div>

                        <!-- 2. NOM A MOSTRAR (Max 50) -->
                        <div class="mb-3">
                            <label for="displayName" class="form-label fw-bold small text-secondary"><fmt:message key="register.nameMostrar" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-tag-fill"></i></span>
                                <input type="text" class="form-control border-start-0 ps-0" id="displayName" name="displayName" 
                                       placeholder="Ex: Joan Garcia" maxlength="50" required>
                            </div>
                        </div>

                        <!-- 3. CONTRASENYA (Max 10) -->
                        <div class="mb-3">
                            <label for="password" class="form-label fw-bold small text-secondary"><fmt:message key="pass" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="password" name="password" 
                                       placeholder="**********" minlength="1" maxlength="10" required>
                            </div>
                        </div>

                        <!-- 4. VERIFICACIÓ CONTRASENYA -->
                        <div class="mb-4">
                            <label for="confirmPassword" class="form-label fw-bold small text-secondary"><fmt:message key="register.passVerif" /></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-shield-lock-fill"></i></span>
                                <input type="password" class="form-control border-start-0 ps-0" id="confirmPassword" name="confirmPassword" 
                                       placeholder="<fmt:message key="register.repeatPass" />" required>
                            </div>

                            <!-- Lógica de error PASSWORD -->
                            <p id="missatgeResultat" class="small mt-1 mb-0 d-none">
                                    <i class="bi bi-exclamation-triangle-fill me-1 "></i>
                                </p>
                        </div>

                        <!-- BOTÓN DE REGISTRO -->
                        <div class="d-grid gap-2">
                            <button type="button" id="btnRegister" class="btn btn-primary btn-register text-white shadow-sm">
                                <fmt:message key="register" />
                            </button>
                        </div>


                    <!-- Pie: Volver al Login -->
                    <div class="text-center mt-4">
                        <small class="text-muted"><fmt:message key="alreadyCompte" /> <a href="login.jsp" class="fw-bold text-decoration-none" style="color: #6610f2;"><fmt:message key="login" /></a></small>
                    </div>

                </div>
            </div>
        </div>
    </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#btnRegister').click(function() {
                   var username = $('#username').val();
                   var name = $('#displayName').val();
                   var pass1 = $('#password').val();
                   var pass2 = $('#confirmPassword').val();
                   
                   $.ajax({
                      type: 'POST',
                      data: {username: username, name: name, pass1: pass1, pass2: pass2},
                      dataType: "json",
                      url: 'Register',
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