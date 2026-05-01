package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "ControladorUsuario", urlPatterns = {"/controladorUsuario"})
public class ControladorUsuario extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String telefono = request.getParameter("ctelefono");
        if (telefono == null) telefono = "";

        Usuario u = new Usuario();
        u.setIdentificacion(request.getParameter("cid"));
        u.setNombre        (request.getParameter("cnombre"));
        u.setApellido      (request.getParameter("capellido"));
        u.setEmail         (request.getParameter("cmail"));
        u.setTelefono      (telefono); 
        u.setUsuario       (request.getParameter("cusuario"));
        u.setClave         (request.getParameter("cclave"));
        u.setPerfil        (request.getParameter("cperfil"));

        System.out.println("=== DATOS RECIBIDOS ===");
        System.out.println("ID:       " + u.getIdentificacion());
        System.out.println("Nombre:   " + u.getNombre());
        System.out.println("Apellido: " + u.getApellido());
        System.out.println("Telefono: " + u.getTelefono());
        System.out.println("Usuario:  " + u.getUsuario());
        System.out.println("Perfil:   " + u.getPerfil());

        int status = new UsuarioDAO().agregarUsuario(u);
        System.out.println("Status BD: " + status);
        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        } else {
            response.sendRedirect("regUsuario.jsp?error=1");
        }
    }
}