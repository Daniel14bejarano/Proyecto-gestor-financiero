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
                padding: 30px;
                align-items: flex-start;
            }
        </style>
    </head>
    <body>
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
                <a href="listaUsuarios.jsp" target="_top" class="link">← Volver a la lista</a>
            </div>
        </div>
    </body>
</html>