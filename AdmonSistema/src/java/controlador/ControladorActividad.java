package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Actividad;
import modelo.ActividadDAO;

@WebServlet(name = "ControladorActividad", urlPatterns = {"/controladorActividad"})
public class ControladorActividad extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        ActividadDAO adao = new ActividadDAO();

        if ("registrar".equals(accion)) {
            Actividad a = new Actividad();
            a.setNomActividad(request.getParameter("nom_actividad"));
            a.setEnlace      (request.getParameter("enlace"));
            adao.registrar(a);
            response.sendRedirect("regActividad.jsp?exito=1");

        } else if ("asignar".equals(accion)) {
            int idPerfil    = Integer.parseInt(request.getParameter("id_perfil"));
            int idActividad = Integer.parseInt(request.getParameter("id_actividad"));
            adao.asignar(idPerfil, idActividad);
            response.sendRedirect("gesActividad.jsp?exito=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            new ActividadDAO().eliminar(id);
            response.sendRedirect("gesActividad.jsp?exito=1");
        }
    }
}
