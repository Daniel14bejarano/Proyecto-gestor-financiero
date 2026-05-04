<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.TransaccionDAO, modelo.Transaccion, java.util.List"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int idUsuario = (int) session.getAttribute("idUsuario");
    List<Transaccion> lista = new TransaccionDAO().listarPorUsuario(idUsuario);
    String exito = request.getParameter("exito");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"><title>GestorF – Registros</title>
        <link rel="stylesheet" href="styles.css">
        <style>body{
            padding:30px;
            align-items:flex-start;
        }</style>
    </head>
    <body>
        <div class="page-header" style="max-width:100%;">
            <h2>Mis <span>Registros</span></h2>
            <div style="display:flex;gap:8px;">
                <a href="regIngreso.jsp" class="btn btn-secondary">+ Ingreso</a>
                <a href="regGasto.jsp"   class="btn btn-secondary">− Gasto</a>
            </div>
        </div>

        <% if (exito != null) { %>
        <div class="alert-error" style="background:rgba(74,222,128,0.1);border-color:var(--success);color:var(--success);margin-bottom:16px;max-width:100%;">
            <% if ("1".equals(exito)) { %>Registro guardado correctamente.
            <% } else if ("2".equals(exito)) { %>Registro actualizado correctamente.
            <% } else if ("3".equals(exito)) { %>Registro eliminado correctamente.<% } %>
        </div>
        <% } %>

        <div class="table-wrapper" style="max-width:100%;">
            <table>
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Tipo</th>
                        <th>Categoría</th>
                        <th>Descripción</th>
                        <th>Monto</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Transaccion t : lista) {
                            boolean esIngreso = "ingreso".equals(t.getTipoCategoria());
                    %>
                    <tr>
                        <td><%=t.getFecha()%></td>
                        <td><span class="badge <%=esIngreso ? "badge-admin" : "badge-user"%>">
                                <%=esIngreso ? "Ingreso" : "Gasto"%>
                            </span></td>
                        <td><%=t.getNombreCategoria()%></td>
                        <td><%=t.getDescripcion() != null ? t.getDescripcion() : ""%></td>
                        <td style="color:<%=esIngreso ? "var(--success)" : "var(--danger)"%>">
                            <%=esIngreso ? "+" : "-"%>$<%=String.format("%,.2f", t.getMonto())%>
                        </td>
                        <td>
                            <div class="td-actions">
                                <a href="editarTransaccion.jsp?id=<%=t.getIdTransaccion()%>" class="btn btn-edit">Editar</a>
                                <a href="controladorTransaccion?accion=eliminar&id=<%=t.getIdTransaccion()%>"
                                   class="btn btn-danger"
                                   onclick="return confirm('¿Eliminar este registro?')">Eliminar</a>
                            </div>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
