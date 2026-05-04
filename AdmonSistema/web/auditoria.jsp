<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.AuditoriaDAO, modelo.Auditoria, java.util.List"%>
<%
  if (session.getAttribute("idUsuario") == null) { response.sendRedirect("login.jsp"); return; }
  String fechaDesde = request.getParameter("fechaDesde");
  String fechaHasta = request.getParameter("fechaHasta");
  AuditoriaDAO adao = new AuditoriaDAO();
  List<Auditoria> lista = (fechaDesde != null && !fechaDesde.isEmpty())
      ? adao.listarPorFecha(fechaDesde, fechaHasta)
      : adao.listarTodas();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>GestorF – Auditoría</title>
  <link rel="stylesheet" href="styles.css">
  <style>body { padding: 30px; align-items: flex-start; }</style>
</head>
<body>

  <div class="page-header" style="max-width:100%;">
    <h2>Reporte de <span>Auditoría</span></h2>
    <a href="dashboard.jsp" class="btn btn-secondary">← Volver</a>
  </div>

  <!-- Filtro por fecha -->
  <div class="card" style="max-width:500px; margin-bottom:24px;">
    <h2 style="font-size:1rem; margin-bottom:16px;">Filtrar por fecha</h2>
    <form method="get" action="auditoria.jsp" style="display:flex; gap:12px; align-items:flex-end;">
      <div class="form-group" style="margin-bottom:0; flex:1;">
        <label>Desde</label>
        <input type="date" name="fechaDesde" value="<%=fechaDesde != null ? fechaDesde : ""%>">
      </div>
      <div class="form-group" style="margin-bottom:0; flex:1;">
        <label>Hasta</label>
        <input type="date" name="fechaHasta" value="<%=fechaHasta != null ? fechaHasta : ""%>">
      </div>
      <button type="submit" class="btn btn-primary" style="width:auto; padding:10px 20px;">Filtrar</button>
      <a href="auditoria.jsp" class="btn btn-secondary" style="padding:10px 16px;">Limpiar</a>
    </form>
  </div>

  <!-- Tabla de auditoría -->
  <div class="table-wrapper" style="max-width:100%;">
    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>ID Transacción</th>
          <th>Acción</th>
          <th>Fecha</th>
          <th>Descripción</th>
        </tr>
      </thead>
      <tbody>
        <% if (lista.isEmpty()) { %>
        <tr>
          <td colspan="5" style="text-align:center; color:var(--muted); padding:30px;">
            No hay registros de auditoría.
          </td>
        </tr>
        <% } else { for (Auditoria a : lista) {
            String badgeClass = "INSERT".equals(a.getAccion()) ? "badge-admin" :
                                "DELETE".equals(a.getAccion()) ? "badge-user" : "";
            String badgeStyle = "UPDATE".equals(a.getAccion()) ?
                                "background:rgba(250,200,80,0.15);color:#f5c842;" : "";
        %>
        <tr>
          <td><%=a.getIdAuditoria()%></td>
          <td><%=a.getIdTransaccion()%></td>
          <td>
            <span class="badge <%=badgeClass%>" style="<%=badgeStyle%>">
              <%=a.getAccion()%>
            </span>
          </td>
          <td><%=a.getFecha()%></td>
          <td><%=a.getDescripcion() != null ? a.getDescripcion() : ""%></td>
        </tr>
        <% } } %>
      </tbody>
    </table>
  </div>

</body>
</html>
