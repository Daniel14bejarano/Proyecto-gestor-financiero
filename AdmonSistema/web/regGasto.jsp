<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.CategoriaDAO, modelo.Categoria, java.util.List"%>
<%
  if (session.getAttribute("idUsuario") == null) { response.sendRedirect("login.jsp"); return; }
  List<Categoria> cats = new CategoriaDAO().listarPorTipo("gasto");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8"><title>GestorF – Registrar Gasto</title>
  <link rel="stylesheet" href="styles.css">
  <style>body{padding:30px;align-items:flex-start;}</style>
</head>
<body>
  <div class="card" style="max-width:500px;">
    <h2>Registrar <span>Gasto</span></h2>
    <% if ("monto".equals(request.getParameter("error"))) { %>
      <div class="alert-error">El monto debe ser mayor que cero.</div>
    <% } %>
    <form action="controladorTransaccion" method="post">
      <input type="hidden" name="accion" value="registrar">
      <div class="form-group">
        <label>Categoría</label>
        <select name="id_categoria" required>
          <% for (Categoria c : cats) { %>
            <option value="<%=c.getIdCategoria()%>"><%=c.getNombre()%></option>
          <% } %>
        </select>
      </div>
      <div class="form-group">
        <label>Fecha</label>
        <input type="date" name="fecha" required>
      </div>
      <div class="form-group">
        <label>Descripción</label>
        <input type="text" name="descripcion">
      </div>
      <div class="form-group">
        <label>Monto</label>
        <input type="number" name="monto" step="0.01" min="0.01" required>
      </div>
      <button type="submit" class="btn btn-primary">Registrar</button>
    </form>
    <div class="actions"><a href="dashboard.jsp" class="link">← Volver</a></div>
  </div>
</body>
</html>
