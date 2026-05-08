package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "ControladorEditarUsuario", urlPatterns = {"/actualizarUsuario"})
public class ControladorEditarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("cidd"));
        String nombre = request.getParameter("cnombre");
        String apellido = request.getParameter("capellido");
        String username = request.getParameter("cusuario");
        String clave = request.getParameter("cclave");
        int idPerfil = Integer.parseInt(request.getParameter("cperfil"));

        Usuario u = new Usuario();
        u.setIdUsuario(id);
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setUsername(username);
        u.setPasswordHash(clave);   // El DAO ya aplica MD5 al guardar
        u.setIdPerfil(idPerfil);

        int status = new UsuarioDAO().actualizarUsuario(u);
        System.out.println("Status actualizar: " + status);

        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        } else {
            response.sendRedirect("editarUsuario.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
