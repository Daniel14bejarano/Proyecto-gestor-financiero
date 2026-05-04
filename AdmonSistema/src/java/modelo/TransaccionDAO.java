package modelo;

import java.sql.*;
import java.util.*;

public class TransaccionDAO {

    public int registrar(Transaccion t) {
        int est = 0;
        String q = "INSERT INTO transacciones (id_usuario, id_categoria, fecha, descripcion, monto) VALUES (?,?,?,?,?)";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, t.getIdUsuario());
            ps.setInt(2, t.getIdCategoria());
            ps.setString(3, t.getFecha());
            ps.setString(4, t.getDescripcion());
            ps.setDouble(5, t.getMonto());
            est = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR registrar transaccion: " + e.getMessage());
        }
        return est;
    }

    public int actualizar(Transaccion t) {
        int est = 0;
        String q = "UPDATE transacciones SET id_categoria=?, fecha=?, descripcion=?, monto=? WHERE id_transaccion=? AND id_usuario=?";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, t.getIdCategoria());
            ps.setString(2, t.getFecha());
            ps.setString(3, t.getDescripcion());
            ps.setDouble(4, t.getMonto());
            ps.setInt(5, t.getIdTransaccion());
            ps.setInt(6, t.getIdUsuario());
            est = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR actualizar transaccion: " + e.getMessage());
        }
        return est;
    }

    public int eliminar(int idTransaccion, int idUsuario) {
        int est = 0;
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "DELETE FROM transacciones WHERE id_transaccion=? AND id_usuario=?")) {
            ps.setInt(1, idTransaccion);
            ps.setInt(2, idUsuario);
            est = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR eliminar transaccion: " + e.getMessage());
        }
        return est;
    }

    public List<Transaccion> listarPorUsuario(int idUsuario) {
        List<Transaccion> lista = new ArrayList<>();
        String q = "SELECT t.*, c.nombre AS nom_cat, c.tipo AS tipo_cat "
                + "FROM transacciones t JOIN categorias c ON t.id_categoria = c.id_categoria "
                + "WHERE t.id_usuario=? ORDER BY t.fecha DESC";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("ERROR listar transacciones: " + e.getMessage());
        }
        return lista;
    }

    public Transaccion buscarPorId(int idTransaccion, int idUsuario) {
        String q = "SELECT t.*, c.nombre AS nom_cat, c.tipo AS tipo_cat "
                + "FROM transacciones t JOIN categorias c ON t.id_categoria = c.id_categoria "
                + "WHERE t.id_transaccion=? AND t.id_usuario=?";
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, idTransaccion);
            ps.setInt(2, idUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            System.out.println("ERROR buscar transaccion: " + e.getMessage());
        }
        return null;
    }

    private Transaccion mapRow(ResultSet rs) throws SQLException {
        Transaccion t = new Transaccion();
        t.setIdTransaccion(rs.getInt("id_transaccion"));
        t.setIdUsuario(rs.getInt("id_usuario"));
        t.setIdCategoria(rs.getInt("id_categoria"));
        t.setNombreCategoria(rs.getString("nom_cat"));
        t.setTipoCategoria(rs.getString("tipo_cat"));
        t.setFecha(rs.getString("fecha"));
        t.setDescripcion(rs.getString("descripcion"));
        t.setMonto(rs.getDouble("monto"));
        t.setFechaRegistro(rs.getString("fecha_registro"));
        return t;
    }
}
