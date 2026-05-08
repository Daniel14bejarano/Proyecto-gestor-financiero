<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="modelo.UsuarioDAO"%>
<%@page import="modelo.Usuario"%>

<%@page import="modelo.PerfilDAO"%>
<%@page import="modelo.Perfil"%>

<%@page import="java.util.List"%>

<%
    // Verificar sesión
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int idPerfil = (int) session.getAttribute("idPerfil");

    // SOLO ADMIN
    if (idPerfil != 1) {
        response.sendRedirect("listaUsuarios.jsp");
        return;
    }

    String nombreCompleto
            = (String) session.getAttribute("nombreCompleto");

    int id = Integer.parseInt(request.getParameter("id"));

    Usuario u = new UsuarioDAO().obtenerPorId(id);

    if (u == null) {
        response.sendRedirect("listaUsuarios.jsp");
        return;
    }

    // CARGAR PERFILES
    List<Perfil> perfiles
            = new PerfilDAO().listarTodos();
%>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">

        <title>Editar Usuario</title>

        <link rel="stylesheet" href="styles.css">

        <style>
            body{
                padding:30px;
            }
        </style>
    </head>

    <body>

        <div class="card">

            <h2>Editar <span>Usuario</span></h2>

            <form action="actualizarUsuario" method="post">

                <input type="hidden"
                       name="cidd"
                       value="<%=u.getIdUsuario()%>">

                <div class="form-group">

                    <label for="cnombre">Nombre</label>

                    <input type="text"
                           name="cnombre"
                           id="cnombre"
                           value="<%=u.getNombre()%>"
                           required>

                </div>

                <div class="form-group">

                    <label for="capellido">Apellido</label>

                    <input type="text"
                           name="capellido"
                           id="capellido"
                           value="<%=u.getApellido()%>"
                           required>

                </div>

                <div class="form-group">

                    <label for="cusuario">Usuario</label>

                    <input type="text"
                           name="cusuario"
                           id="cusuario"
                           value="<%=u.getUsername()%>"
                           required>

                </div>

                <div class="form-group">

                    <label for="cclave">Clave</label>

                    <input type="password"
                           name="cclave"
                           id="cclave"
                           required>

                </div>

                <div class="form-group">

                    <label for="cperfil">Perfil</label>

                    <select name="cperfil" id="cperfil" required>

                        <% for (Perfil p : perfiles) {%>

                        <option value="<%=p.getIdPerfil()%>"
                                <%=u.getIdPerfil() == p.getIdPerfil()
                                        ? "selected"
                                        : ""%>>

                            <%=p.getPerfil()%>

                        </option>

                        <% }%>

                    </select>

                </div>

                <button type="submit"
                        class="btn btn-primary">

                    Guardar cambios

                </button>

            </form>

            <div class="actions">

                <a href="listaUsuarios.jsp"
                   class="link">

                    ← Volver a la lista

                </a>

            </div>

        </div>

    </body>
</html>