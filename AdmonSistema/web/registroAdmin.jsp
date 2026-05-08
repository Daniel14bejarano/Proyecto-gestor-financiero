<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.PerfilDAO, modelo.Perfil, java.util.List"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int idPerfil = (int) session.getAttribute("idPerfil");
    if (idPerfil != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String nombreCompleto = (String) session.getAttribute("nombreCompleto");
    String error = request.getParameter("error");
    List<Perfil> perfiles = new PerfilDAO().listarTodos();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GestorF – Registrar Usuario</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                padding:0;
                align-items:stretch;
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
                font-size:1.2rem;
                font-weight:700;
                color:var(--text);
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
            .dash-content {
                flex:1;
                padding:32px;
                overflow-y:auto;
            }
        </style>
    </head>
    <body>
        <div class="dash-wrapper">
            <div class="dash-header">
                <div class="brand">Gestor<span>F</span></div>
                <div class="dash-user">
                    <span>Hola, <strong><%=nombreCompleto%></strong></span>
                    <a href="logout" class="btn btn-secondary" style="padding:6px 14px;font-size:0.82rem;">Cerrar sesión</a>
                </div>
            </div>


            <div class="dash-content">
                <h2 style="margin-bottom:24px;">Registrar nuevo usuario</h2>

                <div class="card" style="max-width:520px;">
                    <% if ("passwords".equals(error)) { %>
                    <div class="alert-error">Las contraseñas no coinciden.</div>
                    <% } else if ("exists".equals(error)) { %>
                    <div class="alert-error">Ese nombre de usuario ya existe.</div>
                    <% } %>

                    <form action="controladorRegistroAdmin" method="post">
                        <div class="form-group">
                            <label>Nombre</label>
                            <input type="text" name="nombre" required>
                        </div>
                        <div class="form-group">
                            <label>Apellido</label>
                            <input type="text" name="apellido" required>
                        </div>
                        <div class="form-group">
                            <label>Usuario</label>
                            <input type="text" name="username" required>
                        </div>
                        <div class="form-group">
                            <label>Contraseña</label>
                            <input type="password" name="password" required>
                        </div>
                        <div class="form-group">
                            <label>Confirmar contraseña</label>
                            <input type="password" name="confirm" required>
                        </div>
                        <div class="form-group">
                            <label>Perfil</label>
                            <select name="idPerfil">
                                <% for (Perfil p : perfiles) {%>
                                <option value="<%=p.getIdPerfil()%>"><%=p.getPerfil()%></option>
                                <% }%>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Registrar usuario</button>
                    </form>
                    <div class="actions">
                        <a href="listaUsuarios.jsp" class="link">← Volver a la lista</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>