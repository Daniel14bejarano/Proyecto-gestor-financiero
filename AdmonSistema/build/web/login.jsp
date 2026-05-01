<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Si ya hay sesión activa, redirigir directo
    if (session.getAttribute("usuarioLogueado") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Iniciar Sesión</title>
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>

        <div class="card">
            <h2>Iniciar <span>Sesión</span></h2>

            <% if ("1".equals(error)) { %>
            <div class="alert-error">Usuario o contraseña incorrectos.</div>
            <% }%>

            <form action="controladorLogin" method="post">

                <div class="form-group">
                    <label for="cusuario">Usuario</label>
                    <input type="text" name="cusuario" id="cusuario" required autofocus>
                </div>

                <div class="form-group">
                    <label for="cclave">Contraseña</label>
                    <input type="password" name="cclave" id="cclave" required>
                </div>

                <button type="submit" class="btn btn-primary">Entrar</button>
            </form>
            <div class="actions">
                <a href="regUsuario.jsp" class="link">¿No tienes cuenta? Regístrate →</a>
            </div>

        </div>

    </body>
</html>
