package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "ControladorRegistroAdmin", urlPatterns = {"/controladorRegistroAdmin"})
public class ControladorRegistroAdmin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Verificar que sea admin
        if (request.getSession().getAttribute("idUsuario") == null
                || (int) request.getSession().getAttribute("idPerfil") != 1) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        int idPerfil = Integer.parseInt(request.getParameter("idPerfil"));

        UsuarioDAO dao = new UsuarioDAO();

        if (!password.equals(confirm)) {
            response.sendRedirect("registroAdmin.jsp?error=passwords");
            return;
        }
        if (dao.existeUsername(username)) {
            response.sendRedirect("registroAdmin.jsp?error=exists");
            return;
        }

        Usuario u = new Usuario();
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setUsername(username);
        u.setPasswordHash(password);
        u.setIdPerfil(idPerfil);

        int resultado = dao.registrarConPerfil(u);
        System.out.println("Resultado insercion admin: " + resultado);

        response.sendRedirect("listaUsuarios.jsp?exito=1");
    }
}
