package modelo;

import java.sql.*;
import java.util.*;

public class CategoriaDAO {

    public List<Categoria> listarPorTipo(String tipo) {
        List<Categoria> lista = new ArrayList<>();
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM categorias WHERE tipo=? ORDER BY nombre")) {
            ps.setString(1, tipo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("ERROR listar categorias: " + e.getMessage());
        }
        return lista;
    }

    public List<Categoria> listarTodas() {
        List<Categoria> lista = new ArrayList<>();
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement("SELECT * FROM categorias ORDER BY tipo, nombre"); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.out.println("ERROR listar todas categorias: " + e.getMessage());
        }
        return lista;
    }

    private Categoria mapRow(ResultSet rs) throws SQLException {
        Categoria c = new Categoria();
        c.setIdCategoria(rs.getInt("id_categoria"));
        c.setNombre(rs.getString("nombre"));
        c.setTipo(rs.getString("tipo"));
        c.setDescripcion(rs.getString("descripcion"));
        return c;
    }
}
