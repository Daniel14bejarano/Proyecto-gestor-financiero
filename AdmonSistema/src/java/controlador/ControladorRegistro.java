package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "ControladorRegistro", urlPatterns = {"/controladorRegistro"})
public class ControladorRegistro extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        System.out.println("=== REGISTRO ===");
        System.out.println("nombre:   " + nombre);
        System.out.println("apellido: " + apellido);
        System.out.println("username: " + username);
        System.out.println("password: " + password);
        System.out.println("confirm:  " + confirm);

        UsuarioDAO dao = new UsuarioDAO();

        if (!password.equals(confirm)) {
            System.out.println("ERROR: passwords no coinciden");
            response.sendRedirect("registro.jsp?error=passwords");
            return;
        }
        if (dao.existeUsername(username)) {
            System.out.println("ERROR: username ya existe");
            response.sendRedirect("registro.jsp?error=exists");
            return;
        }

        Usuario u = new Usuario();
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setUsername(username);
        u.setPasswordHash(password);
        int resultado = dao.registrar(u);
        System.out.println("Resultado insercion: " + resultado);
        response.sendRedirect("login.jsp?exito=1");
    }
}
