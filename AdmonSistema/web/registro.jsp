<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("idUsuario") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GestorF – Registro</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <div class="card">
            <h2>Crear <span>Cuenta</span></h2>

            <% if ("passwords".equals(error)) { %>
            <div class="alert-error">Las contraseñas no coinciden.</div>
            <% } else if ("exists".equals(error)) { %>
            <div class="alert-error">Ese nombre de usuario ya existe.</div>
            <% }%>

            <form action="controladorRegistro" method="post">
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
                <button type="submit" class="btn btn-primary">Registrarse</button>
            </form>
            <div class="actions">
                <a href="login.jsp" class="link">← Ya tengo cuenta</a>
            </div>
        </div>
    </body>
</html>
