<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.UsuarioDAO, modelo.Usuario, modelo.ActividadDAO, modelo.Actividad, java.util.List"%>
<%
  if (session.getAttribute("usuarioLogueado") == null) {
      response.sendRedirect("login.jsp");
      return;
  }
  String nombreUsuario = (String) session.getAttribute("usuarioLogueado");
  String perfil        = (String) session.getAttribute("perfilUsuario");
  boolean esAdmin      = "admin".equals(perfil);

  // Traer nombre y apellido del usuario en sesión
  UsuarioDAO udao = new UsuarioDAO();
  // Traer actividades según perfil
  ActividadDAO adao = new ActividadDAO();
  List<Actividad> menu = adao.listarPorPerfil(perfil);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    body { padding: 0; align-items: stretch; min-height: 100vh; }

    .dash-wrapper {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      width: 100%;
    }

    /* Header */
    .dash-header {
      background: var(--surface);
      border-bottom: 1px solid var(--border);
      padding: 14px 32px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      animation: fadeUp 0.3s ease both;
    }

    .dash-header .brand {
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--text);
      letter-spacing: -0.3px;
    }

    .dash-header .brand span { color: var(--accent); }

    .dash-user {
      display: flex;
      align-items: center;
      gap: 14px;
      font-size: 0.88rem;
      color: var(--muted);
    }

    .dash-user strong { color: var(--text); }

    /* Layout */
    .dash-body {
      display: flex;
      flex: 1;
    }

    /* Sidebar */
    .dash-sidebar {
      width: 220px;
      min-width: 220px;
      background: var(--surface);
      border-right: 1px solid var(--border);
      padding: 24px 0;
      display: flex;
      flex-direction: column;
      animation: fadeUp 0.4s ease both;
    }

    .sidebar-label {
      font-size: 0.7rem;
      font-weight: 600;
      color: var(--muted);
      text-transform: uppercase;
      letter-spacing: 0.1em;
      padding: 0 20px;
      margin-bottom: 10px;
    }

    .sidebar-link {
      display: block;
      padding: 10px 20px;
      color: var(--muted);
      text-decoration: none;
      font-size: 0.9rem;
      border-left: 3px solid transparent;
      transition: all 0.15s;
    }

    .sidebar-link:hover {
      color: var(--text);
      background: rgba(108,99,255,0.07);
      border-left-color: var(--accent);
    }

    .sidebar-link.admin-link { color: var(--accent); }
    .sidebar-link.admin-link:hover { background: rgba(108,99,255,0.12); }

    /* Content iframe */
    .dash-content {
      flex: 1;
      background: var(--bg);
      animation: fadeUp 0.5s ease both;
    }

    .dash-content iframe {
      width: 100%;
      height: 100%;
      border: none;
      min-height: calc(100vh - 57px);
    }
  </style>
</head>
<body>

<div class="dash-wrapper">

  <!-- Header -->
  <div class="dash-header">
    <div class="brand">Admin<span>Sistema</span></div>
    <div class="dash-user">
      <span>Hola, <strong><%=nombreUsuario%></strong></span>
      <span class="badge <%=esAdmin ? "badge-admin" : "badge-user"%>">
        <%=esAdmin ? "Admin" : "Usuario"%>
      </span>
      <a href="logout" class="btn btn-secondary" style="padding:6px 14px;font-size:0.82rem;">Cerrar sesión</a>
    </div>
  </div>

  <div class="dash-body">

    <!-- Sidebar menú dinámico -->
    <div class="dash-sidebar">
      <div class="sidebar-label">Menú</div>

      <%-- Actividades dinámicas desde BD según perfil --%>
      <% for (Actividad act : menu) { %>
        <a href="<%=act.getEnlace()%>" target="marco" class="sidebar-link">
          <%=act.getNomActividad()%>
        </a>
      <% } %>

      <%-- Opciones exclusivas de admin --%>
      <% if (esAdmin) { %>
        <div class="sidebar-label" style="margin-top:20px;">Administración</div>
        <a href="regActividad.jsp" target="marco" class="sidebar-link admin-link">Registro de actividades</a>
        <a href="gesActividad.jsp" target="marco" class="sidebar-link admin-link">Gestión de actividades</a>
      <% } %>
    </div>

    <!-- Panel principal -->
    <div class="dash-content">
      <iframe name="marco" src="front.jsp" frameborder="0"></iframe>
    </div>

  </div>
</div>

</body>
</html>
