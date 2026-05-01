<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  if (session.getAttribute("usuarioLogueado") == null) { response.sendRedirect("login.jsp"); return; }
  String perfil = (String) session.getAttribute("perfilUsuario");
  boolean esAdmin = "admin".equals(perfil);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lista de Usuarios</title>
  <link rel="stylesheet" href="styles.css">
  <style>body { padding: 30px; align-items: flex-start; }</style>
</head>
<body>
  <div class="page-header" style="max-width:100%;">
    <h2>Listado de <span>Usuarios</span></h2>
  </div>
  <div class="table-wrapper" style="max-width:100%;">
    <table>
      <thead>
        <tr>
          <th>Identificación</th>
          <th>Nombre</th>
          <th>Apellido</th>
          <th>Email</th>
          <th>Teléfono</th>
          <th>Usuario</th>
          <% if (esAdmin) { %><th>Contraseña</th><% } %>
          <th>Perfil</th>
          <% if (esAdmin) { %><th>Acciones</th><% } %>
        </tr>
      </thead>
      <tbody>
        <%
          UsuarioDAO udao = new UsuarioDAO();
          List<Usuario> lista = udao.ListadoUsuarios();
          for (Usuario a : lista) {
            String perfilClass = a.getPerfil().equalsIgnoreCase("admin") ? "badge-admin" : "badge-user";
            String tel = a.getTelefono() != null ? a.getTelefono() : "";
        %>
        <tr>
          <td><%=a.getIdentificacion()%></td>
          <td><%=a.getNombre()%></td>
          <td><%=a.getApellido()%></td>
          <td><%=a.getEmail()%></td>
          <td><%=tel%></td>
          <td><%=a.getUsuario()%></td>
          <% if (esAdmin) { %><td><%=a.getClave()%></td><% } %>
          <td><span class="badge <%=perfilClass%>"><%=a.getPerfil()%></span></td>
          <% if (esAdmin) { %>
          <td>
            <div class="td-actions">
              <a href="EditarUsuario.jsp?id=<%=a.getIddato()%>" class="btn btn-edit">Editar</a>
              <a href="eliminarUsuario?id=<%=a.getIddato()%>" class="btn btn-danger"
                 onclick="return confirm('¿Eliminar este usuario?')">Eliminar</a>
            </div>
          </td>
          <% } %>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</body>
</html>
