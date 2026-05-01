<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.UsuarioDAO, modelo.Usuario"%>
<%
  // Solo admins pueden editar
  if (session.getAttribute("usuarioLogueado") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String perfil = (String) session.getAttribute("perfilUsuario");
  if (!"admin".equals(perfil)) {
      response.sendRedirect("listaUsuarios.jsp");
      return;
  }
  String nombreUsuario = (String) session.getAttribute("usuarioLogueado");

  UsuarioDAO udao = new UsuarioDAO();
  int id = Integer.parseInt(request.getParameter("id"));
  Usuario a = udao.listarDatos_Id(id);
  String tel = a.getTelefono() != null ? a.getTelefono() : "";
  String email = a.getEmail() != null ? a.getEmail() : "";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Editar Usuario</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

  <div class="topbar">
    <span>Hola, <strong><%=nombreUsuario%></strong> &nbsp;|&nbsp; <span class="badge badge-admin">Admin</span></span>
    <a href="logout" class="btn btn-secondary">Cerrar sesión</a>
  </div>

  <div class="card">
    <h2>Editar <span>Usuario</span></h2>
    <form action="editarUsuario" method="post">
      <input type="hidden" name="cidd" value="<%=a.getIddato()%>">

      <div class="form-group">
        <label for="cid">Identificación</label>
        <input type="text" name="cid" id="cid" value="<%=a.getIdentificacion()%>" required>
      </div>
      <div class="form-group">
        <label for="cnombre">Nombre</label>
        <input type="text" name="cnombre" id="cnombre" value="<%=a.getNombre()%>" required>
      </div>
      <div class="form-group">
        <label for="capellido">Apellido</label>
        <input type="text" name="capellido" id="capellido" value="<%=a.getApellido()%>" required>
      </div>
      <div class="form-group">
        <label for="cmail">Email</label>
        <input type="email" name="cmail" id="cmail" value="<%=email%>">
      </div>
      <div class="form-group">
        <label for="ctelefono">Teléfono</label>
        <input type="text" name="ctelefono" id="ctelefono" value="<%=tel%>">
      </div>
      <div class="form-group">
        <label for="cusuario">Usuario</label>
        <input type="text" name="cusuario" id="cusuario" value="<%=a.getUsuario()%>" required>
      </div>
      <div class="form-group">
        <label for="cclave">Clave</label>
        <input type="password" name="cclave" id="cclave" value="<%=a.getClave()%>" required>
      </div>
      <div class="form-group">
        <label for="cperfil">Perfil</label>
        <select name="cperfil" id="cperfil">
          <option value="admin" <%=a.getPerfil().equals("admin") ? "selected" : ""%>>Administrador</option>
          <option value="user"  <%=a.getPerfil().equals("user")  ? "selected" : ""%>>Usuario</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary">Guardar cambios</button>
    </form>
    <div class="actions">
      <a href="listaUsuarios.jsp" class="link">← Volver a la lista</a>
    </div>
  </div>

</body>
</html>
