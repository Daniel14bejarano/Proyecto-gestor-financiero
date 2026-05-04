<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("idUsuario") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String error = request.getParameter("error");
    String exito = request.getParameter("exito");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>GestorF – Iniciar Sesión</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <div class="card">
            <h2>Bienvenido a <span>GestorF</span></h2>
            <p style="color:var(--muted);font-size:0.9rem;margin-bottom:24px;">Tu gestor de finanzas personales</p>

            <% if ("1".equals(error)) { %>
            <div class="alert-error">Usuario o contraseña incorrectos.</div>
            <% } %>
            <% if ("1".equals(exito)) { %>
            <div class="alert-error" style="background:rgba(74,222,128,0.1);border-color:var(--success);color:var(--success);">
                Cuenta creada exitosamente. Inicia sesión.
            </div>
            <% }%>

            <form action="controladorLogin" method="post">
                <div class="form-group">
                    <label>Usuario</label>
                    <input type="text" name="username" required autofocus>
                </div>
                <div class="form-group">
                    <label>Contraseña</label>
                    <input type="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary">Iniciar sesión</button>
            </form>
            <div class="actions">
                <a href="registro.jsp" class="link">¿No tienes cuenta? Regístrate →</a>
            </div>
        </div>
    </body>
</html>
