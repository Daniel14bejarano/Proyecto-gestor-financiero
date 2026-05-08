package controlador;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
    "/listaUsuarios.jsp",
    "/registroAdmin.jsp",
    "/gestionPerfiles.jsp",
    "/regActividad.jsp",
    "/gesActividad.jsp",
    // SERVLETS ADMIN
    "/controladorPerfil",
    "/controladorRegistroAdmin",
    "/actualizarUsuario",
    "/eliminarUsuario"
})
public class FiltroAdmin implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession sesion = req.getSession(false);

        // No hay sesión
        if (sesion == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        Integer idPerfil = (Integer) sesion.getAttribute("idPerfil");

        // Solo admin puede entrar
        if (idPerfil == null || idPerfil != 1) {
            res.sendRedirect("dashboard.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
