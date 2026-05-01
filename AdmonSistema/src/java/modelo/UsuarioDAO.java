package modelo;

import Interfaces.CRUD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO implements CRUD {

    @Override
    public int agregarUsuario(Usuario u) {
        int estatus = 0;
        String q = "INSERT INTO usuarios (identificacion, nombre, apellido, email, telefono, usuario, clave, id_perfil) "
                 + "VALUES (?, ?, ?, ?, ?, ?, ?, (SELECT id_perfil FROM perfiles WHERE perfil=?))";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, u.getIdentificacion());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getUsuario());
            ps.setString(7, u.getClave());
            ps.setString(8, u.getPerfil()); // "administrador" o "usuario"
            estatus = ps.executeUpdate();
            System.out.println("REGISTRO GUARDADO EXITOSAMENTE");

        } catch (SQLException ex) {
            System.out.println("ERROR AL REGISTRAR: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int actualizarDatos(Usuario u) {
        int estatus = 0;
        String q = "UPDATE usuarios SET identificacion=?, nombre=?, apellido=?, email=?, "
                 + "telefono=?, usuario=?, clave=?, "
                 + "id_perfil=(SELECT id_perfil FROM perfiles WHERE perfil=?) "
                 + "WHERE idusu=?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, u.getIdentificacion());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getUsuario());
            ps.setString(7, u.getClave());
            ps.setString(8, u.getPerfil());
            ps.setInt(9,    u.getIddato());
            estatus = ps.executeUpdate();
            System.out.println("REGISTRO ACTUALIZADO");

        } catch (SQLException ex) {
            System.out.println("ERROR AL ACTUALIZAR: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int eliminarDatos(int id) {
        int estatus = 0;
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(
                 "DELETE FROM usuarios WHERE idusu=?")) {

            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            System.out.println("REGISTRO ELIMINADO");

        } catch (SQLException ex) {
            System.out.println("ERROR AL ELIMINAR: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public Usuario listarDatos_Id(int id) {
        Usuario u = new Usuario();
        String q = "SELECT u.*, p.perfil FROM usuarios u "
                 + "JOIN perfiles p ON u.id_perfil = p.id_perfil "
                 + "WHERE u.idusu=?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) mapRow(rs, u);

        } catch (SQLException ex) {
            System.out.println("ERROR AL BUSCAR: " + ex.getMessage());
        }
        return u;
    }

    @Override
    public List<Usuario> ListadoUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String q = "SELECT u.*, p.perfil FROM usuarios u "
                 + "JOIN perfiles p ON u.id_perfil = p.id_perfil";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                mapRow(rs, u);
                lista.add(u);
            }

        } catch (SQLException ex) {
            System.out.println("ERROR EN LISTADO: " + ex.getMessage());
        }
        return lista;
    }

    public Usuario validarLogin(String usuario, String clave) {
        Usuario u = null;
        String q = "SELECT u.*, p.perfil FROM usuarios u "
                 + "JOIN perfiles p ON u.id_perfil = p.id_perfil "
                 + "WHERE u.usuario=? AND u.clave=?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, usuario);
            ps.setString(2, clave);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                mapRow(rs, u);
            }

        } catch (SQLException ex) {
            System.out.println("ERROR EN LOGIN: " + ex.getMessage());
        }
        return u;
    }

    private void mapRow(ResultSet rs, Usuario u) throws SQLException {
        u.setIddato        (rs.getInt   ("idusu"));
        u.setIdentificacion(rs.getString("identificacion"));
        u.setNombre        (rs.getString("nombre"));
        u.setApellido      (rs.getString("apellido"));
        u.setEmail         (rs.getString("email"));
        u.setTelefono      (rs.getString("telefono"));
        u.setUsuario       (rs.getString("usuario"));
        u.setClave         (rs.getString("clave"));
        u.setPerfil        (rs.getString("perfil"));
    }
}