<%-- 
    Document   : adminGestioUsers
    Created on : Mar 4, 2026, 9:31:17 AM
    Author     : admin
--%>

<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="admin.users.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <style>
        /* Estilos base (Fondo y tarjetas de cristal) */
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

        /* Contenedor para la tabla scrolleable */
        .table-scroll-container {
            max-height: 65vh; 
            overflow-y: auto;  
            border-radius: 0.5rem;
            border: 1px solid #e9ecef;
        }

        .table-scroll-container thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }

        /* Botón de Alta Usuari */
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

        /* Botones de acción en la tabla */
        .btn-action-icon {
            padding: 0.3rem 0.5rem;
            border-radius: 0.5rem;
            transition: transform 0.2s;
        }
        .btn-action-icon:hover {
            transform: scale(1.1);
        }
        /* Botón de editar (Modificar) */
        .btn-edit {
            color: #0d6efd;
            background-color: rgba(13, 110, 253, 0.1);
        }
        .btn-edit:hover {
            background-color: #0d6efd;
            color: white;
        }
        
        /* Píldora decorativa para el rol de Admin */
        .badge-admin {
            background-color: #dc3545;
            color: white;
            padding: 0.35em 0.65em;
            border-radius: 50rem;
            font-size: 0.85em;
            font-weight: 600;
        }
        /* Píldora para usuario normal */
        .badge-user {
            background-color: #6c757d;
            color: white;
            padding: 0.35em 0.65em;
            border-radius: 50rem;
            font-size: 0.85em;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>
    
    <!-- CONTENIDO PRINCIPAL -->
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-xl-11">
                
                <!-- He puesto el borde de arriba en rojo (#dc3545) para mantener la temática de admin -->
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #dc3545 !important;">
                    
                    <!-- CABECERA: Título a la izquierda, Botón a la derecha -->
                    <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-people-fill text-danger" style="font-size: 2.5rem;"></i>
                            <div>
                                <h2 class="display-6 brand-gradient mb-0" style="background: -webkit-linear-gradient(45deg, #dc3545, #6610f2); -webkit-background-clip: text;"><fmt:message key="admin.users.title" /></h2>
                                <p class="text-secondary mb-0"><fmt:message key="admin.users.subtitle" /></p>
                            </div>
                        </div>
                        
                        <!-- Botón Alta Usuari -->
                        <a href="adminNewUser.jsp" class="btn btn-custom-purple shadow-sm">
                            <i class="bi bi-person-plus-fill me-1"></i> <fmt:message key="admin.users.addBtn" />
                        </a>
                    </div>

                        <!-- Estado vacío -->
                        <div id="mensajeVacioUsuarios" class="d-none alert alert-light border border-secondary text-center py-5 rounded-4 mt-3">
                            <i class="bi bi-person-x text-muted" style="font-size: 3rem;"></i>
                            <h5 class="mt-3 text-secondary fw-bold"><fmt:message key="admin.users.empty" /></h5>
                        </div>
                        
                        
                        <div id="contenedorTablaUsuarios" class="d-none"></div>

                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    
    <script>
        $(document).ready(function() {

            cargarUsuarios();

            function cargarUsuarios() {
                
                $('#contenedorTablaUsuarios').addClass('d-none');
                $('#mensajeVacioUsuarios').addClass('d-none');

                $.ajax({
                    url: 'AdminGestioUsers',
                    type: 'GET',
                    dataType: 'json',
                    success: function(llista) {
                        var $div = $('#contenedorTablaUsuarios'); 
                        var $divVacio = $('#mensajeVacioUsuarios');
                        $div.empty();

                        if (!llista || llista.length === 0) {
                            $div.addClass('d-none'); 
                            $divVacio.removeClass('d-none');
                        } else {
                            $div.removeClass('d-none');
                            var html = '<div class="table-scroll-container mt-3 shadow-sm">';
                            html += '<table class="table table-hover align-middle mb-0 fs-5">';
                            html += '<thead><tr>';
                            html += '<th style="width: 25%;" class="text-secondary"><fmt:message key="admin.users.col.username" /></th>';
                            html += '<th style="width: 35%;" class="text-secondary"><fmt:message key="admin.users.col.displayName" /></th>';
                            html += '<th style="width: 20%;" class="text-secondary"><fmt:message key="admin.users.col.type" /></th>';
                            html += '<th style="width: 20%;" class="text-secondary text-center"><fmt:message key="admin.users.col.actions" /></th>';
                            html += '</tr></thead>';
                            html += '<tbody id="cuerpoTablaUsuarios">';

                            $.each(llista, function(i, u) {
                                var badge = u.admin 
                                    ? '<span class="badge-admin"><i class="bi bi-shield-lock-fill me-1"></i> Admin</span>' 
                                    : '<span class="badge-user"><i class="bi bi-person-fill me-1"></i> Usuari</span>';

                                html += '<tr>';
                                html += '<td class="py-3"><i class="bi bi-person-badge text-secondary me-2"></i>';
                                html += '<span class="fw-bold text-dark">' + u.username + '</span></td>';

                                html += '<td class="py-3 text-dark">' + u.nom + '</td>';

                                html += '<td class="py-3">' + badge + '</td>';

                                html += '<td class="text-center"><div class="d-flex justify-content-center gap-2">';

                                html += '<form action="AdminGestioUsers" method="POST" class="m-0 p-0" style="display:inline;">';
                                html += '  <input type="hidden" name="username" value="' + u.username + '">';
                                html += '  <button type="submit" class="btn btn-action-icon btn-edit border-0">';
                                html += '    <i class="bi bi-pencil-fill"></i>';
                                html += '  </button>';
                                html += '</form>';

                                html += '<button type="button" onclick="eliminarUsuario(this, \'' + u.username + '\')" class="btn btn-action-icon btn-outline-danger border-0">';
                                html += '  <i class="bi bi-trash-fill"></i>';
                                html += '</button>';

                                html += '</div></td></tr>';
                            });

                            html += '</tbody></table></div>';
                            $div.append(html);
                        }
                    },
                    error: function() {
                        alert("Error al carregar els usuaris");
                    }
                });
            }
        });

        function eliminarUsuario(tr, username) {
            if (confirm("<fmt:message key="inbox.deteleAsk" />")) {
                $.ajax({
                    type: 'POST',
                    url: 'AdminDeleteUser',
                    data: { username: username },
                    dataType: 'json',
                    success: function(resposta) {
                        if (resposta.status === "OK") {
                            alert(resposta.message);
                            $(tr).closest('tr').fadeOut(400, function() {
                                $(this).remove();
                                if ($('#cuerpoTablaUsuarios tr').length === 0) {
                                    $('#contenedorTablaUsuarios').addClass('d-none');
                                    $('#mensajeVacioUsuarios').removeClass('d-none');
                                }
                            });
                        } else {
                            alert("Error: " + resposta.message);
                        }
                    },
                    error: function() {
                        alert("Error de xarxa al eliminar l'usuari.");
                    }
                });
            }
        }
    </script>

</body>
</html>