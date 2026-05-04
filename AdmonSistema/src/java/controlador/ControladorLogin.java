package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "ControladorLogin", urlPatterns = {"/controladorLogin"})
public class ControladorLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario u = dao.validarLogin(username, password);

        if (u != null) {
            HttpSession session = request.getSession();
            session.setAttribute("idUsuario", u.getIdUsuario());
            session.setAttribute("username", u.getUsername());
            session.setAttribute("nombreCompleto", u.getNombre() + " " + u.getApellido());
            session.setAttribute("idPerfil", u.getIdPerfil());
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
