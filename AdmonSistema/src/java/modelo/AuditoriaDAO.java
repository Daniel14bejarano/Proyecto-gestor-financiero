package modelo;

import java.sql.*;
import java.util.*;

public class AuditoriaDAO {

    public List<Auditoria> listarTodas() {
        List<Auditoria> lista = new ArrayList<>();
        String q = "SELECT * FROM auditoria_transacciones ORDER BY fecha DESC";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("ERROR listar auditoria: " + e.getMessage());
        }
        return lista;
    }

    public List<Auditoria> listarPorFecha(String desde, String hasta) {
        List<Auditoria> lista = new ArrayList<>();
        String q = "SELECT * FROM auditoria_transacciones "
                 + "WHERE DATE(fecha) BETWEEN ? AND ? ORDER BY fecha DESC";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {
            ps.setString(1, desde);
            ps.setString(2, hasta != null && !hasta.isEmpty() ? hasta : desde);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapRow(rs));
        } catch (SQLException e) {
            System.out.println("ERROR listar auditoria por fecha: " + e.getMessage());
        }
        return lista;
    }

    private Auditoria mapRow(ResultSet rs) throws SQLException {
        Auditoria a = new Auditoria();
        a.setIdAuditoria  (rs.getInt   ("id_auditoria"));
        a.setIdTransaccion(rs.getInt   ("id_transaccion"));
        a.setAccion       (rs.getString("accion"));
        a.setFecha        (rs.getString("fecha"));
        a.setDescripcion  (rs.getString("descripcion"));
        return a;
    }
}
