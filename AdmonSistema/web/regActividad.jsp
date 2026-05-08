<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if ((int) session.getAttribute("idPerfil") != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String exito = request.getParameter("exito");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Registro de Actividades</title>
        <link rel="stylesheet" href="styles.css">
        <style>body {
                padding: 30px;
                align-items: flex-start;
            }</style>
    </head>
    <body>
        <div class="card" style="max-width:480px;">
            <h2>Registro de <span>Actividad</span></h2>

            <% if ("1".equals(exito)) { %>
            <div class="alert-error" style="background:rgba(74,222,128,0.1);border-color:var(--success);color:var(--success);">
                Actividad registrada correctamente.
            </div>
            <% }%>

            <form action="controladorActividad" method="post">
                <input type="hidden" name="accion" value="registrar">
                <div class="form-group">
                    <label>Nombre de la actividad</label>
                    <input type="text" name="nom_actividad" required>
                </div>
                <div class="form-group">
                    <label>Enlace (JSP destino)</label>
                    <input type="text" name="enlace" placeholder="ej: listaUsuarios.jsp" required>
                </div>
                <button type="submit" class="btn btn-primary">Registrar</button>
            </form>
        </div>
    </body>
</html>
