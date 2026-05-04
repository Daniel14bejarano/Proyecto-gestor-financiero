<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.BalanceDAO, modelo.Balance"%>
<%
  if (session.getAttribute("idUsuario") == null) { response.sendRedirect("login.jsp"); return; }
  int     idUsuario     = (int)    session.getAttribute("idUsuario");
  String  nombreCompleto = (String) session.getAttribute("nombreCompleto");
  Balance b = new BalanceDAO().obtenerPorUsuario(idUsuario);
  String colorBalance = b.getBalanceActual() >= 0 ? "var(--success)" : "var(--danger)";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8"><title>GestorF – Balance</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    body{padding:30px;align-items:flex-start;}
    .balance-big { background:var(--surface); border:1px solid var(--border); border-radius:16px; padding:40px; max-width:500px; }
    .balance-row { display:flex; justify-content:space-between; padding:14px 0; border-bottom:1px solid var(--border); font-size:1rem; }
    .balance-row:last-child { border-bottom:none; font-size:1.3rem; font-weight:700; padding-top:20px; }
    .val-ingreso { color:var(--success); }
    .val-gasto   { color:var(--danger); }
  </style>
</head>
<body>
  <h2 style="margin-bottom:24px;">Balance de <span style="color:var(--accent)"><%=nombreCompleto%></span></h2>
  <div class="balance-big">
    <div class="balance-row">
      <span>Total ingresos</span>
      <span class="val-ingreso">+$<%=String.format("%,.2f", b.getTotalIngresos())%></span>
    </div>
    <div class="balance-row">
      <span>Total gastos</span>
      <span class="val-gasto">-$<%=String.format("%,.2f", b.getTotalGastos())%></span>
    </div>
    <div class="balance-row">
      <span>Balance actual</span>
      <span style="color:<%=colorBalance%>">$<%=String.format("%,.2f", b.getBalanceActual())%></span>
    </div>
  </div>
  <div class="actions" style="margin-top:20px;">
    <a href="dashboard.jsp" class="link">← Volver al inicio</a>
  </div>
</body>
</html>
