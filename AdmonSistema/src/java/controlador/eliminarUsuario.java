package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.UsuarioDAO;

@WebServlet(name = "EliminarUsuario", urlPatterns = {"/eliminarUsuario"})
public class eliminarUsuario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        System.out.println("Eliminando ID: " + id);

        int status = new UsuarioDAO().eliminarUsuario(id);
        System.out.println("Status eliminar: " + status);

        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        } else {
            response.sendRedirect("listaUsuarios.jsp?error=1");
        }
    }
}