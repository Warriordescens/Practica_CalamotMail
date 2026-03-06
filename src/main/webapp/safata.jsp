<%-- 
    Document   : safata
    Created on : Mar 1, 2026, 5:59:19 PM
    Author     : admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.User"%>
<%@page import="com.mycompany.pwp2hernandezguerreroalex.model.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CalamotMail - <fmt:message key="inbox.title" /></title>
    
    <!-- Bootstrap CSS 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

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

        /* Contenedor para hacer la tabla scrolleable */
        .table-scroll-container {
            max-height: 400px; /* Altura máxima antes de mostrar la barra */
            overflow-y: auto;  /* Muestra la barra vertical solo si es necesario */
            border-radius: 0.5rem;
            border: 1px solid #e9ecef;
        }

        /* Fijar la cabecera de la tabla arriba aunque hagamos scroll */
        .table-scroll-container thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }

        /* Ajustes de botones de acción de la tabla */
        .btn-action-icon {
            padding: 0.3rem 0.5rem;
            border-radius: 0.5rem;
            transition: transform 0.2s;
        }
        .btn-action-icon:hover {
            transform: scale(1.1);
        }
        .btn-view {
            color: #6610f2;
            background-color: rgba(102, 16, 242, 0.1);
        }
        .btn-view:hover {
            background-color: #6610f2;
            color: white;
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <%@include file="WEB-INF/jspf/navbar.jspf" %>


    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-xl-15">
                
                <div class="card glass-card p-4 p-md-5 border-top border-5" style="border-top-color: #6610f2 !important;">
                    
                    <div class="mb-4 d-flex align-items-center gap-3">
                        <i class="bi bi-inbox-fill text-primary" style="font-size: 2.5rem; color: #6610f2 !important;"></i>
                        <div>
                            <h2 class="display-6 brand-gradient mb-0"><fmt:message key="inbox.title" /></h2>
                        </div>
                    </div>
                        
                        <div id="mensajeVacio" class="alert alert-light border border-secondary text-center py-5 rounded-4 mt-3" >
                            <i class="bi bi-envelope-paper text-muted" style="font-size: 3rem;"></i>
                            <h5 class="mt-3 text-secondary fw-bold"><fmt:message key="inbox.empty" /></h5>
                        </div>

                        <div id="contenedorTabla" ></div>
                    
                    
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            
            
            $(document).ready(function() {
                
                cargarMensajes();
                
                function cargarMensajes() {
                    
                    $('#contenedorTabla').addClass('d-none');
                    $('#mensajeVacio').addClass('d-none');
                    
                    $.ajax({
                        url: 'Safata',
                        type: 'GET',
                        dataType: 'json',
                        success: function(llista) {
                            var $div = $('#contenedorTabla'); 
                            var $divVacio = $('#mensajeVacio');
                            $div.empty().removeClass('d-none');

                            if (!llista || llista.length === 0) {
                                    $div.addClass('d-none'); 
                                    $divVacio.removeClass('d-none');
                            } else {
                                var html = '<div class="table-scroll-container mt-3 shadow-sm">';
                                html += '<table class="table table-hover align-middle mb-0">';
                                html += '<thead><tr>';
                                html += '<th class="text-secondary">Emisor</th>';
                                html += '<th class="text-secondary">Assumpte</th>';
                                html += '<th class="text-secondary">Data</th>';
                                html += '<th class="text-secondary text-center">Accions</th>';
                                html += '</tr></thead>';
                                html += '<tbody id="cuerpoTablaMissatges">';

                                $.each(llista, function(i, m) {
                                    var isLlegit = m.is_read;
                                    var fwClass = isLlegit ? "" : "fw-bold text-dark";
                                    var filaClass = isLlegit ? "" : "table-light";
                                    var icon = isLlegit ? "bi-envelope" : "bi-envelope-fill text-primary";

                                    html += '<tr class="' + filaClass + '">';
                                    html += '<td class="' + fwClass + ' py-3"><i class="bi ' + icon + ' me-2"></i>' + m.emisor.username + '</td>';
                                    html += '<td class="' + fwClass + ' py-3">' + m.subject + '</td>';
                                    html += '<td class="' + fwClass + ' py-3 text-muted small">' + m.fecha + '</td>';
                                    html += '<td class="text-center">';
                                    html += '<div class="d-flex justify-content-center gap-2">';

                                    html += '<form action="Safata" method="POST" style="display:inline;">';
                                    html += '  <input type="hidden" name="id" value="' + m.id + '">';
                                    html += '  <button type="submit" class="btn btn-action-icon btn-view" title="Veure">';
                                    html += '    <i class="bi bi-eye-fill"></i>';
                                    html += '  </button>';
                                    html += '</form>';

                                    html += '<button type="button" onclick="eliminar(this,' + m.id + ')" class="btn btn-action-icon btn-outline-danger border-0"><i class="bi bi-trash-fill"></i></button>';

                                    html += '</div></td></tr>';
                                });

                                html += '</tbody></table></div>';

                                $div.append(html);
                            }
                        },
                        error: function() {
                            $('#missatgeResultat')
                                .removeClass('d-none text-success')
                                .addClass('text-danger')
                                .text("Error al connectar amb el servidor");
                        }
                    });
                }
            });
            
            function eliminar(btn, id) {
                if (confirm("<fmt:message key="inbox.deteleAsk" />")) {
                    $.ajax({
                        type: 'POST',
                        url: 'MessageServlet',
                        data: { id: id },
                        dataType: 'json',
                        success: function(resposta) {
                            if (resposta.status === "OK") {
                                alert(resposta.message);
                                $(btn).closest('tr').fadeOut(400, function() { // fadeout para que parezca que desapareze poco a poco para hacerlo mas visual :)
                                    $(this).remove();

                                    if ($('#cuerpoTablaMissatges tr').length === 0) {
                                         $('#contenedorTabla').addClass('d-none');
                                         $('#mensajeVacio').removeClass('d-none');
                                    }
                                }); 
                            } else {
                                alert("No s'ha pogut eliminar: " + resposta.message);
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error("Error en la petición:", error);
                            alert("Error de red al intentar eliminar.");
                        }
                    });
                }
            }
            
        </script>
</body>
</html>
