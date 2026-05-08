package modelo;

import java.sql.*;

public class UsuarioDAO {

    public Usuario validarLogin(String username, String password) {
        Usuario u = null;
        String q = "SELECT u.*, p.perfil "
                + "FROM usuarios u "
                + "JOIN perfiles p ON u.id_perfil = p.id_perfil "
                + "WHERE username=? AND password_hash=? AND estado='activo'";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setString(1, username);
            ps.setString(2, getMD5(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                mapRow(rs, u);
            }
        } catch (SQLException e) {
            System.out.println("ERROR login: " + e.getMessage());
        }
        return u;
    }

    public int registrar(Usuario u) {
        int est = 0;
        String q = "INSERT INTO usuarios (nombre, apellido, id_perfil, username, password_hash) VALUES (?,?,2,?,?)";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getUsername());
            ps.setString(4, getMD5(u.getPasswordHash()));
            est = ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                int newId = keys.getInt(1);
                try (PreparedStatement ps2 = con.prepareStatement(
                        "INSERT INTO balances (id_usuario, total_ingresos, total_gastos, balance_actual) VALUES (?,0,0,0)")) {
                    ps2.setInt(1, newId);
                    ps2.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.out.println("ERROR registrar usuario: " + e.getMessage());
        }
        return est;
    }

    public boolean existeUsername(String username) {
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "SELECT id_usuario FROM usuarios WHERE username=?")) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("ERROR existeUsername: " + e.getMessage());
            return false;
        }
    }

    private String getMD5(String input) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(input.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return input;
        }
    }

    public java.util.List<Usuario> listarTodos() {

        java.util.List<Usuario> lista = new java.util.ArrayList<>();

        String q = "SELECT u.*, p.perfil "
                + "FROM usuarios u "
                + "JOIN perfiles p ON u.id_perfil = p.id_perfil";

        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Usuario u = new Usuario();

                u.setIdUsuario(rs.getInt("id_usuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setIdPerfil(rs.getInt("id_perfil"));
                u.setPerfil(rs.getString("perfil"));
                u.setUsername(rs.getString("username"));
                u.setPasswordHash(rs.getString("password_hash"));
                u.setEstado(rs.getString("estado"));

                lista.add(u);
            }

        } catch (SQLException e) {
            System.out.println("ERROR listarTodos: " + e.getMessage());
        }

        return lista;
    }

    private void mapRow(ResultSet rs, Usuario u) throws SQLException {
        u.setIdUsuario(rs.getInt("id_usuario"));
        u.setNombre(rs.getString("nombre"));
        u.setApellido(rs.getString("apellido"));
        u.setIdPerfil(rs.getInt("id_perfil"));
        u.setUsername(rs.getString("username"));
        u.setPasswordHash(rs.getString("password_hash"));
        u.setEstado(rs.getString("estado"));
        u.setPerfil(rs.getString("perfil"));
    }

    public int actualizarUsuario(Usuario u) {
        String q = "UPDATE usuarios SET nombre=?, apellido=?, username=?, password_hash=?, id_perfil=? WHERE id_usuario=?";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getUsername());
            ps.setString(4, getMD5(u.getPasswordHash()));
            ps.setInt(5, u.getIdPerfil());
            ps.setInt(6, u.getIdUsuario());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR actualizar: " + e.getMessage());
            return 0;
        }
    }

    public int eliminarUsuario(int id) {
        String q = "DELETE FROM usuarios WHERE id_usuario=?";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, id);
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR eliminar: " + e.getMessage());
            return 0;
        }
    }

    public Usuario obtenerPorId(int id) {
        String q = "SELECT * FROM usuarios WHERE id_usuario=?";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                mapRow(rs, u);
                return u;
            }
        } catch (SQLException e) {
            System.out.println("ERROR obtenerPorId: " + e.getMessage());
        }
        return null;
    }

    public int registrarConPerfil(Usuario u) {
        String q = "INSERT INTO usuarios (nombre, apellido, id_perfil, username, password_hash) VALUES (?,?,?,?,?)";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setInt(3, u.getIdPerfil());
            ps.setString(4, u.getUsername());
            ps.setString(5, getMD5(u.getPasswordHash()));
            int est = ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                int newId = keys.getInt(1);
                try (PreparedStatement ps2 = con.prepareStatement(
                        "INSERT INTO balances (id_usuario, total_ingresos, total_gastos, balance_actual) VALUES (?,0,0,0)")) {
                    ps2.setInt(1, newId);
                    ps2.executeUpdate();
                }
            }
            return est;
        } catch (SQLException e) {
            System.out.println("ERROR registrarConPerfil: " + e.getMessage());
            return 0;
        }
    }
}
