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

        String usuario = request.getParameter("cusuario");
        String clave   = request.getParameter("cclave");

        UsuarioDAO udao = new UsuarioDAO();
        Usuario u = udao.validarLogin(usuario, clave);

        if (u != null) {
            // Login correcto: guardar usuario en sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", u.getUsuario());
            session.setAttribute("perfilUsuario",   u.getPerfil());
            response.sendRedirect("dashboard.jsp");
        } else {
            // Login incorrecto
            response.sendRedirect("login.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
