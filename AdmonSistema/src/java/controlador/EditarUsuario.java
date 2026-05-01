package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "EditarUsuario", urlPatterns = {"/editarUsuario"})
public class EditarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("cidd"));
        String ident = request.getParameter("cid");
        String nombre = request.getParameter("cnombre");
        String apellido = request.getParameter("capellido");
        String email = request.getParameter("cmail");
        String usuario = request.getParameter("cusuario");
        String clave = request.getParameter("cclave");
        String perfil = request.getParameter("cperfil");
        String telefono = request.getParameter("ctelefono");
        if (telefono == null) {
            telefono = "";
        }

        Usuario a = new Usuario();
        a.setIddato(id);
        a.setIdentificacion(ident);
        a.setNombre(nombre);
        a.setApellido(apellido);
        a.setEmail(email);
        a.setTelefono(telefono);
        a.setUsuario(usuario);
        a.setClave(clave);
        a.setPerfil(perfil);

        int status = new UsuarioDAO().actualizarDatos(a);
        System.out.println("Status actualizar: " + status);

        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        } else {
            response.sendRedirect("EditarUsuario.jsp?error=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
