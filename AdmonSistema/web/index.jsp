<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
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
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Registro de Usuario</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

  <div class="topbar">
    <span>Hola, <strong><%=nombreUsuario%></strong> &nbsp;|&nbsp; <span class="badge badge-admin">Admin</span></span>
    <a href="logout" class="btn btn-secondary">Cerrar sesión</a>
  </div>

  <div class="card">
    <h1>Registro de <span>Usuario</span></h1>
    <form action="controladorUsuario" method="post">
      <div class="form-group">
        <label for="cid">Identificación</label>
        <input type="text" name="cid" id="cid" required>
      </div>
      <div class="form-group">
        <label for="cnombre">Nombre</label>
        <input type="text" name="cnombre" id="cnombre" required>
      </div>
      <div class="form-group">
        <label for="capellido">Apellido</label>
        <input type="text" name="capellido" id="capellido" required>
      </div>
      <div class="form-group">
        <label for="cmail">Email</label>
        <input type="email" name="cmail" id="cmail">
      </div>
      <div class="form-group">
        <label for="ctelefono">Teléfono</label>
        <input type="text" name="ctelefono" id="ctelefono">
      </div>
      <div class="form-group">
        <label for="cusuario">Usuario</label>
        <input type="text" name="cusuario" id="cusuario" required>
      </div>
      <div class="form-group">
        <label for="cclave">Clave</label>
        <input type="password" name="cclave" id="cclave" required>
      </div>
      <div class="form-group">
        <label for="cperfil">Perfil</label>
        <select name="cperfil" id="cperfil">
          <option value="admin">Administrador</option>
          <option value="user">Usuario</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary">Registrar</button>
    </form>
    <div class="actions">
      <a href="listaUsuarios.jsp" class="link">Ver lista de usuarios →</a>
    </div>
  </div>

</body>
</html>
