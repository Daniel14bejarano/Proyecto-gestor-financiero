<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
  if (session.getAttribute("usuarioLogueado") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String perfil       = (String) session.getAttribute("perfilUsuario");
  String nombreUsuario = (String) session.getAttribute("usuarioLogueado");
  boolean esAdmin     = "admin".equals(perfil);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lista de Usuarios</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

  <div class="topbar">
    <span>Hola, <strong><%=nombreUsuario%></strong> &nbsp;|&nbsp;
      <span class="badge <%=esAdmin ? "badge-admin" : "badge-user"%>"><%=esAdmin ? "Admin" : "Usuario"%></span>
    </span>
    <a href="logout" class="btn btn-secondary">Cerrar sesión</a>
  </div>

  <div class="page-header">
    <h2>Listado de <span>Usuarios</span></h2>
    <% if (esAdmin) { %>
      <a href="index.jsp" class="btn btn-secondary">+ Nuevo usuario</a>
    <% } %>
  </div>

  <div class="table-wrapper">
    <table>
      <thead>
        <tr>
          <th>Identificación</th>
          <th>Nombre</th>
          <th>Apellido</th>
          <th>Email</th>
          <th>Teléfono</th>
          <th>Usuario</th>
          <th>Contraseña</th>
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
          <td><%=a.getClave()%></td>
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
        <%
          }
        %>
      </tbody>
    </table>
  </div>

</body>
</html>
