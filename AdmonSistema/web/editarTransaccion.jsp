<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.TransaccionDAO, modelo.Transaccion, modelo.CategoriaDAO, modelo.Categoria, java.util.List"%>
<%
    if (session.getAttribute("idUsuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int idUsuario = (int) session.getAttribute("idUsuario");
    int idTransaccion = Integer.parseInt(request.getParameter("id"));
    Transaccion t = new TransaccionDAO().buscarPorId(idTransaccion, idUsuario);
    if (t == null) {
        response.sendRedirect("registros.jsp");
        return;
    }
    List<Categoria> cats = new CategoriaDAO().listarTodas();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"><title>GestorF – Editar Registro</title>
        <link rel="stylesheet" href="styles.css">
        <style>body{
            padding:30px;
            align-items:flex-start;
        }</style>
    </head>
    <body>
        <div class="card" style="max-width:500px;">
            <h2>Editar <span>Registro</span></h2>
            <% if ("monto".equals(request.getParameter("error"))) { %>
            <div class="alert-error">El monto debe ser mayor que cero.</div>
            <% }%>
            <form action="controladorTransaccion" method="post">
                <input type="hidden" name="accion" value="actualizar">
                <input type="hidden" name="id_transaccion" value="<%=t.getIdTransaccion()%>">
                <div class="form-group">
                    <label>Categoría</label>
                    <select name="id_categoria" required>
                        <% for (Categoria c : cats) {%>
                        <option value="<%=c.getIdCategoria()%>"
                                <%=c.getIdCategoria() == t.getIdCategoria() ? "selected" : ""%>>
                            <%=c.getTipo().equals("ingreso") ? "📈" : "📉"%> <%=c.getNombre()%>
                        </option>
                        <% }%>
                    </select>
                </div>
                <div class="form-group">
                    <label>Fecha</label>
                    <input type="date" name="fecha" value="<%=t.getFecha()%>" required>
                </div>
                <div class="form-group">
                    <label>Descripción</label>
                    <input type="text" name="descripcion" value="<%=t.getDescripcion() != null ? t.getDescripcion() : ""%>">
                </div>
                <div class="form-group">
                    <label>Monto</label>
                    <input type="number" name="monto" step="0.01" min="0.01" value="<%=t.getMonto()%>" required>
                </div>
                <button type="submit" class="btn btn-primary">Guardar cambios</button>
            </form>
            <div class="actions"><a href="registros.jsp" class="link">← Volver</a></div>
        </div>
    </body>
</html>
