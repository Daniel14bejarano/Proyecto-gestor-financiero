<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.ActividadDAO, modelo.Actividad, modelo.PerfilDAO, modelo.Perfil, java.util.List"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idUsuario = (int) session.getAttribute("idUsuario");
    int idPerfil = (int) session.getAttribute("idPerfil");
    String nombreCompleto = (String) session.getAttribute("nombreCompleto");

    // Obtener nombre del perfil
    Perfil perfil = new PerfilDAO().obtenerPorId(idPerfil);
    String nomPerfil = perfil != null ? perfil.getPerfil() : "";

    // SOLO admin
    boolean esAdmin = idPerfil == 1;

    // Menú dinámico
    List<Actividad> menu = new ActividadDAO().listarPorPerfil(nomPerfil);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GestorF – Dashboard</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                padding:0;
                align-items:stretch;
                min-height:100vh;
            }
            .dash-wrapper {
                display:flex;
                flex-direction:column;
                min-height:100vh;
                width:100%;
            }
            .dash-header {
                background:var(--surface);
                border-bottom:1px solid var(--border);
                padding:14px 32px;
                display:flex;
                justify-content:space-between;
                align-items:center;
            }
            .brand {
                font-size:1.1rem;
                font-weight:600;
                color:var(--text);
                letter-spacing:-0.3px;
            }
            .brand span {
                color:var(--accent);
            }
            .dash-user {
                display:flex;
                align-items:center;
                gap:14px;
                font-size:0.88rem;
                color:var(--muted);
            }
            .dash-user strong {
                color:var(--text);
            }
            .dash-body {
                display:flex;
                flex:1;
            }
            .dash-sidebar {
                width:220px;
                min-width:220px;
                background:var(--surface);
                border-right:1px solid var(--border);
                padding:24px 0;
                display:flex;
                flex-direction:column;
            }
            .sidebar-label {
                font-size:0.7rem;
                font-weight:600;
                color:var(--muted);
                text-transform:uppercase;
                letter-spacing:0.1em;
                padding:0 20px;
                margin-bottom:10px;
            }
            .sidebar-link {
                display:block;
                padding:10px 20px;
                color:var(--muted);
                text-decoration:none;
                font-size:0.9rem;
                border-left:3px solid transparent;
                transition:all 0.15s;
            }
            .sidebar-link:hover {
                color:var(--text);
                background:rgba(108,99,255,0.07);
                border-left-color:var(--accent);
            }
            .sidebar-link.admin-link {
                color:var(--accent);
            }
            .sidebar-link.admin-link:hover {
                background:rgba(108,99,255,0.12);
            }
            .dash-content {
                flex:1;
                background:var(--bg);
            }
            .dash-content iframe {
                width:100%;
                height:100%;
                border:none;
                min-height:calc(100vh - 57px);
            }
        </style>
    </head>
    <body>
        <div class="dash-wrapper">

            <div class="dash-header">
                <div class="brand">Gestor<span>F</span></div>
                <div class="dash-user">
                    <span>Hola, <strong><%=nombreCompleto%></strong></span>
                    <span class="badge <%=esAdmin ? "badge-admin" : "badge-user"%>">
                        <%=nomPerfil%>
                    </span>
                    <a href="logout" class="btn btn-secondary" style="padding:6px 14px;font-size:0.82rem;">Cerrar sesión</a>
                </div>
            </div>

            <div class="dash-body">
                <div class="dash-sidebar">
                    <div class="sidebar-label">Menú</div>

                    <%-- Actividades dinámicas desde BD según perfil --%>
                    <% for (Actividad act : menu) {%>
                    <a href="<%=act.getEnlace()%>" target="marco" class="sidebar-link">
                        <%=act.getNomActividad()%>
                    </a>
                    <% } %>

                    <%-- Opciones exclusivas de admin --%>
                    <% if (esAdmin) { %>
                    <div class="sidebar-label" style="margin-top:20px;">Administración</div>
                    <a href="listaUsuarios.jsp"   target="marco" class="sidebar-link admin-link">Lista de usuarios</a>
                    <a href="registroAdmin.jsp"   target="marco" class="sidebar-link admin-link">Registrar usuario</a>
                    <a href="gestionPerfiles.jsp" target="marco" class="sidebar-link admin-link">Gestión de perfiles</a>
                    <a href="regActividad.jsp"    target="marco" class="sidebar-link admin-link">Registro de actividades</a>
                    <a href="gesActividad.jsp"    target="marco" class="sidebar-link admin-link">Gestión de actividades</a>
                    <% }%>
                </div>

                <div class="dash-content">
                    <iframe name="marco" src="balance.jsp" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </body>
</html>