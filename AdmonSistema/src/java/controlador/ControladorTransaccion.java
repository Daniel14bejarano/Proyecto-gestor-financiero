package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Transaccion;
import modelo.TransaccionDAO;

@WebServlet(name = "ControladorTransaccion", urlPatterns = {"/controladorTransaccion"})
public class ControladorTransaccion extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        int idUsuario = (int) request.getSession().getAttribute("idUsuario");
        TransaccionDAO dao = new TransaccionDAO();

        if ("registrar".equals(accion)) {
            double monto = Double.parseDouble(request.getParameter("monto"));
            if (monto <= 0) {
                response.sendRedirect(request.getHeader("Referer") + "?error=monto");
                return;
            }
            Transaccion t = new Transaccion();
            t.setIdUsuario(idUsuario);
            t.setIdCategoria(Integer.parseInt(request.getParameter("id_categoria")));
            t.setFecha(request.getParameter("fecha"));
            t.setDescripcion(request.getParameter("descripcion"));
            t.setMonto(monto);
            dao.registrar(t);
            response.sendRedirect("registros.jsp?exito=1");

        } else if ("actualizar".equals(accion)) {
            double monto = Double.parseDouble(request.getParameter("monto"));
            if (monto <= 0) {
                response.sendRedirect("editarTransaccion.jsp?error=monto&id=" + request.getParameter("id_transaccion"));
                return;
            }
            Transaccion t = new Transaccion();
            t.setIdTransaccion(Integer.parseInt(request.getParameter("id_transaccion")));
            t.setIdUsuario(idUsuario);
            t.setIdCategoria(Integer.parseInt(request.getParameter("id_categoria")));
            t.setFecha(request.getParameter("fecha"));
            t.setDescripcion(request.getParameter("descripcion"));
            t.setMonto(monto);
            dao.actualizar(t);
            response.sendRedirect("registros.jsp?exito=2");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("eliminar".equals(accion)) {
            int idUsuario = (int) request.getSession().getAttribute("idUsuario");
            int idTransaccion = Integer.parseInt(request.getParameter("id"));
            System.out.println("=== ELIMINAR TRANSACCION ===");
            System.out.println("idTransaccion: " + idTransaccion);
            System.out.println("idUsuario:     " + idUsuario);
            int resultado = new TransaccionDAO().eliminar(idTransaccion, idUsuario);
            System.out.println("Resultado eliminar: " + resultado);
            response.sendRedirect("registros.jsp?exito=3");
        }
    }
}
