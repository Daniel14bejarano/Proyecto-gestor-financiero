<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.BalanceDAO, modelo.Balance"%>
<%
  if (session.getAttribute("idUsuario") == null) { response.sendRedirect("login.jsp"); return; }
  int    idUsuario     = (int)    session.getAttribute("idUsuario");
  String nombreCompleto = (String) session.getAttribute("nombreCompleto");
  Balance b = new BalanceDAO().obtenerPorUsuario(idUsuario);
  String colorBalance = b.getBalanceActual() >= 0 ? "var(--success)" : "var(--danger)";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>GestorF – Dashboard</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    body { padding: 0; align-items: stretch; }
    .dash-wrapper { display:flex; flex-direction:column; min-height:100vh; width:100%; }
    .dash-header {
      background:var(--surface); border-bottom:1px solid var(--border);
      padding:14px 32px; display:flex; justify-content:space-between; align-items:center;
    }
    .brand { font-size:1.2rem; font-weight:700; color:var(--text); }
    .brand span { color:var(--accent); }
    .dash-user { display:flex; align-items:center; gap:14px; font-size:0.88rem; color:var(--muted); }
    .dash-body { display:flex; flex:1; }
    .dash-sidebar {
      width:220px; min-width:220px; background:var(--surface);
      border-right:1px solid var(--border); padding:24px 0;
    }
    .sidebar-label {
      font-size:0.7rem; font-weight:600; color:var(--muted);
      text-transform:uppercase; letter-spacing:0.1em; padding:0 20px; margin-bottom:10px;
    }
    .sidebar-link {
      display:block; padding:10px 20px; color:var(--muted); text-decoration:none;
      font-size:0.9rem; border-left:3px solid transparent; transition:all 0.15s;
    }
    .sidebar-link:hover { color:var(--text); background:rgba(108,99,255,0.07); border-left-color:var(--accent); }
    .dash-content { flex:1; padding:32px; overflow-y:auto; }

    /* Balance cards */
    .balance-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:16px; margin-bottom:32px; }
    .balance-card {
      background:var(--surface); border:1px solid var(--border);
      border-radius:12px; padding:20px 24px;
    }
    .balance-card .label { font-size:0.75rem; color:var(--muted); text-transform:uppercase; letter-spacing:0.08em; margin-bottom:8px; }
    .balance-card .valor { font-size:1.6rem; font-weight:700; }
    .balance-card .valor.ingreso { color:var(--success); }
    .balance-card .valor.gasto   { color:var(--danger); }
  </style>
</head>
<body>
<div class="dash-wrapper">
  <div class="dash-header">
    <div class="brand">Gestor<span>F</span></div>
    <div class="dash-user">
      <span>Hola, <strong><%=nombreCompleto%></strong></span>
      <a href="logout" class="btn btn-secondary" style="padding:6px 14px;font-size:0.82rem;">Cerrar sesión</a>
    </div>
  </div>

  <div class="dash-body">
    <div class="dash-sidebar">
      <div class="sidebar-label">Menú</div>
      <a href="dashboard.jsp"       class="sidebar-link">🏠 Inicio</a>
      <a href="regIngreso.jsp"      class="sidebar-link">➕ Registrar ingreso</a>
      <a href="regGasto.jsp"        class="sidebar-link">➖ Registrar gasto</a>
      <a href="registros.jsp"       class="sidebar-link">📋 Ver registros</a>
      <a href="balance.jsp"         class="sidebar-link">📊 Ver balance</a>
      <a href="logout"              class="sidebar-link">🚪 Cerrar sesión</a>
    </div>

    <div class="dash-content">
      <h2 style="margin-bottom:24px;">Resumen financiero</h2>

      <div class="balance-grid">
        <div class="balance-card">
          <div class="label">Total ingresos</div>
          <div class="valor ingreso">$<%=String.format("%,.2f", b.getTotalIngresos())%></div>
        </div>
        <div class="balance-card">
          <div class="label">Total gastos</div>
          <div class="valor gasto">$<%=String.format("%,.2f", b.getTotalGastos())%></div>
        </div>
        <div class="balance-card">
          <div class="label">Balance actual</div>
          <div class="valor" style="color:<%=colorBalance%>">$<%=String.format("%,.2f", b.getBalanceActual())%></div>
        </div>
      </div>

      <div style="display:flex;gap:12px;">
        <a href="regIngreso.jsp" class="btn btn-primary" style="width:auto;padding:10px 24px;">+ Registrar ingreso</a>
        <a href="regGasto.jsp"   class="btn btn-secondary" style="padding:10px 24px;">− Registrar gasto</a>
        <a href="registros.jsp"  class="btn btn-secondary" style="padding:10px 24px;">Ver todos los registros</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
