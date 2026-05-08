<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.PerfilDAO, modelo.Perfil, java.util.List"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if ((int)session.getAttribute("idPerfil") != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    String nombreUsuario = (String) session.getAttribute("nombreCompleto");
    String exito = request.getParameter("exito");
    String error = request.getParameter("error");
    List<Perfil> perfiles = new PerfilDAO().listarTodos();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Perfiles</title>
        <link rel="stylesheet" href="styles.css">
        <style>body {
                padding: 30px;
                align-items: flex-start;
            }</style>
    </head>
    <body>

        <div class="topbar" style="max-width:900px;">
            <span>Hola, <strong><%=nombreUsuario%></strong> &nbsp;|&nbsp; <span class="badge badge-admin">Admin</span></span>
            <div style="display:flex;gap:8px;">
                <a href="dashboard.jsp" class="btn btn-secondary">← Panel</a>
                <a href="logout" class="btn btn-secondary">Cerrar sesión</a>
            </div>
        </div>

        <div style="max-width:900px; width:100%; display:flex; gap:24px; margin-top:8px;">

            <!-- Formulario crear perfil -->
            <div class="card" style="max-width:340px; height:fit-content;">
                <h2>Nuevo <span>Perfil</span></h2>

                <% if ("1".equals(exito)) { %>
                <div class="alert-error" style="background:rgba(74,222,128,0.1);border-color:var(--success);color:var(--success);">
                    Perfil creado correctamente.
                </div>
                <% } else if ("exists".equals(error)) { %>
                <div class="alert-error">Ese perfil ya existe.</div>
                <% } %>

                <form action="controladorPerfil" method="post">
                    <input type="hidden" name="accion" value="crear">
                    <div class="form-group">
                        <label>Nombre del perfil</label>
                        <input type="text" name="perfil" required placeholder="ej: supervisor">
                    </div>
                    <button type="submit" class="btn btn-primary">Crear perfil</button>
                </form>
            </div>

            <!-- Lista de perfiles -->
            <div style="flex:1;">
                <h2 style="margin-bottom:16px;">Perfiles <span style="color:var(--accent)">registrados</span></h2>
                <div class="table-wrapper" style="max-width:100%;">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Perfil</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Perfil p : perfiles) {%>
                            <tr>
                                <td><%=p.getIdPerfil()%></td>
                                <td><span class="badge <%=p.getPerfil().equals("admin") ? "badge-admin" : "badge-user"%>">
                                        <%=p.getPerfil()%>
                                    </span></td>
                                <td>
                                    <% if (!p.getPerfil().equals("admin") && !p.getPerfil().equals("user")) {%>
                                    <a href="controladorPerfil?accion=eliminar&id=<%=p.getIdPerfil()%>"
                                       class="btn btn-danger"
                                       onclick="return confirm('¿Eliminar este perfil?')">Eliminar</a>
                                    <% } else { %>
                                    <span style="color:var(--muted);font-size:0.8rem;">Protegido</span>
                                    <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <!-- Asignar perfil a usuario -->
        <div class="card" style="max-width:900px; margin-top:24px;">
            <h2>Asignar <span>Perfil</span> a usuario</h2>
            <%@page import="modelo.UsuarioDAO, modelo.Usuario"%>
            <%
                java.util.List<Usuario> usuarios = new UsuarioDAO().listarTodos();
            %>
            <form action="controladorPerfil" method="post" style="display:flex; gap:16px; align-items:flex-end; flex-wrap:wrap;">
                <input type="hidden" name="accion" value="asignar">
                <div class="form-group" style="margin-bottom:0; flex:1; min-width:200px;">
                    <label>Usuario</label>
                    <select name="id_usuario" required>
                        <% for (Usuario u : usuarios) {%>
                        <option value="<%=u.getIdUsuario()%>"><%=u.getNombre()%> <%=u.getApellido()%> (<%=u.getUsername()%>)</option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group" style="margin-bottom:0; flex:1; min-width:200px;">
                    <label>Perfil a asignar</label>
                    <select name="id_perfil" required>
                        <% for (Perfil p : perfiles) {%>
                        <option value="<%=p.getIdPerfil()%>"><%=p.getPerfil()%></option>
                        <% }%>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary" style="width:auto; padding:10px 24px;">Asignar</button>
            </form>
        </div>

    </body>
</html>
