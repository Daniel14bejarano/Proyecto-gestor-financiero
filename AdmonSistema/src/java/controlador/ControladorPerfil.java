package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.PerfilDAO;

@WebServlet(name = "ControladorPerfil", urlPatterns = {"/controladorPerfil"})
public class ControladorPerfil extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Verificar que sea admin
        if (!"admin".equals(request.getSession().getAttribute("perfilUsuario"))) {
            response.sendRedirect("listaUsuarios.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        PerfilDAO dao = new PerfilDAO();

        if ("crear".equals(accion)) {
            String perfil = request.getParameter("perfil");
            if (dao.existe(perfil)) {
                response.sendRedirect("gestionPerfiles.jsp?error=exists");
            } else {
                dao.crear(perfil);
                response.sendRedirect("gestionPerfiles.jsp?exito=1");
            }

        } else if ("asignar".equals(accion)) {
            int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
            int idPerfil = Integer.parseInt(request.getParameter("id_perfil"));
            dao.asignarAUsuario(idUsuario, idPerfil);
            response.sendRedirect("gestionPerfiles.jsp?exito=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Verificar que sea admin
        if ((int) request.getSession().getAttribute("idPerfil") != 1) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            new PerfilDAO().eliminar(id);
            response.sendRedirect("gestionPerfiles.jsp?exito=1");
        }
    }
}
