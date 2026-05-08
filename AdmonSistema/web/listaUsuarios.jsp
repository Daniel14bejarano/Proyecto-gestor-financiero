<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int idPerfil = (int) session.getAttribute("idPerfil");
    String nombreUsuario = (String) session.getAttribute("nombreCompleto");
    boolean esAdmin = idPerfil == 1;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lista de Usuarios</title>
        <link rel="stylesheet" href="styles.css">
        <style>body {
            padding: 30px;
            align-items: flex-start;
        }</style>
    </head>
    <body>
        <div class="topbar" style="max-width:100%;">
            <span>Hola, <strong><%=nombreUsuario%></strong> &nbsp;|&nbsp;
                <span class="badge <%=esAdmin ? "badge-admin" : "badge-user"%>"><%=esAdmin ? "Admin" : "Usuario"%></span>
            </span>
            <div style="display:flex;gap:8px;">
                <a href="dashboard.jsp" class="btn btn-secondary">← Panel</a>
                <a href="logout" class="btn btn-secondary">Cerrar sesión</a>
            </div>
        </div>

        <div class="page-header" style="max-width:100%;">
            <h2>Listado de <span>Usuarios</span></h2>
        </div>

        <div class="table-wrapper" style="max-width:100%;">
            <table>
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Username</th>
                        <th>Perfil</th>
                        <th>Estado</th>
                        <% if (esAdmin) { %><th>Acciones</th><% } %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        UsuarioDAO udao = new UsuarioDAO();
                        List<Usuario> lista = udao.listarTodos();
                        for (Usuario u : lista) {
                            String perfilClass = u.getIdPerfil() == 1 ? "badge-admin" : "badge-user";
                    %>
                    <tr>
                        <td><%=u.getNombre()%></td>
                        <td><%=u.getApellido()%></td>
                        <td><%=u.getUsername()%></td>
                        <td><span class="badge <%=perfilClass%>"><%=u.getEstado()%></span></td>
                        <td><%=u.getEstado()%></td>
                        <% if (esAdmin) { %>
                        <td>
                            <div class="td-actions">
                                <a href="gestionPerfiles.jsp" class="btn btn-edit">Gestionar perfil</a>
                            </div>
                        </td>
                        <% } %>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>