<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.ActividadDAO, modelo.Actividad, modelo.PerfilDAO, modelo.Perfil, java.util.List"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if ((int) session.getAttribute("idPerfil") != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    ActividadDAO adao = new ActividadDAO();
    List<Actividad> todas = adao.listarTodas();
    List<Perfil> perfiles = new PerfilDAO().listarTodos();
    String exito = request.getParameter("exito");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Actividades</title>
        <link rel="stylesheet" href="styles.css">
        <style>body {
                padding: 30px;
                align-items: flex-start;
            }</style>
    </head>
    <body>

        <div style="max-width:700px; width:100%;">
            <h2 style="margin-bottom:20px;">Gestión de <span style="color:var(--accent)">Actividades</span></h2>

            <% if ("1".equals(exito)) { %>
            <div class="alert-error" style="background:rgba(74,222,128,0.1);border-color:var(--success);color:var(--success);margin-bottom:16px;">
                Asignación actualizada correctamente.
            </div>
            <% } %>

            <!-- Asignar actividad a perfil -->
            <div class="card" style="margin-bottom:24px;">
                <h2 style="font-size:1rem;margin-bottom:16px;">Asignar actividad a perfil</h2>
                <form action="controladorActividad" method="post">
                    <input type="hidden" name="accion" value="asignar">
                    <div class="form-group">
                        <label>Perfil</label>
                        <select name="id_perfil">
                            <% for (Perfil p : perfiles) {%>
                            <option value="<%=p.getIdPerfil()%>"><%=p.getPerfil()%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Actividad</label>
                        <select name="id_actividad">
                            <% for (Actividad a : todas) {%>
                            <option value="<%=a.getIdActividad()%>"><%=a.getNomActividad()%></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Asignar</button>
                </form>
            </div>

            <!-- Lista de actividades registradas -->
            <div class="table-wrapper" style="max-width:100%;">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Actividad</th>
                            <th>Enlace</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Actividad a : todas) {%>
                        <tr>
                            <td><%=a.getIdActividad()%></td>
                            <td><%=a.getNomActividad()%></td>
                            <td><%=a.getEnlace()%></td>
                            <td>
                                <a href="controladorActividad?accion=eliminar&id=<%=a.getIdActividad()%>"
                                   class="btn btn-danger"
                                   onclick="return confirm('¿Eliminar esta actividad?')">Eliminar</a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

    </body>
</html>
