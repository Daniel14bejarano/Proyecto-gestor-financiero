package modelo;

import java.sql.*;
import java.util.*;

public class PerfilDAO {

    public List<Perfil> listarTodos() {
        List<Perfil> lista = new ArrayList<>();
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement("SELECT * FROM perfiles ORDER BY id_perfil"); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Perfil p = new Perfil();
                p.setIdPerfil(rs.getInt("id_perfil"));
                p.setPerfil(rs.getString("perfil"));
                lista.add(p);
            }
        } catch (SQLException e) {
            System.out.println("ERROR listar perfiles: " + e.getMessage());
        }
        return lista;
    }

    public boolean existe(String perfil) {
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "SELECT id_perfil FROM perfiles WHERE perfil=?")) {
            ps.setString(1, perfil);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            return false;
        }
    }

    public int crear(String perfil) {
        int est = 0;
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "INSERT INTO perfiles (perfil) VALUES (?)")) {
            ps.setString(1, perfil.toLowerCase().trim());
            est = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR crear perfil: " + e.getMessage());
        }
        return est;
    }

    public int eliminar(int idPerfil) {
        int est = 0;
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "DELETE FROM perfiles WHERE id_perfil=?")) {
            ps.setInt(1, idPerfil);
            est = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ERROR eliminar perfil: " + e.getMessage());
        }
        return est;
    }

    public int asignarAUsuario(int idUsuario, int idPerfil) {
    int est = 0;
    try (Connection con = new Conexion().crearConexion()) {
        // Obtener nombre del perfil
        String nombrePerfil = null;
        try (PreparedStatement ps = con.prepareStatement(
                "SELECT perfil FROM perfiles WHERE id_perfil=?")) {
            ps.setInt(1, idPerfil);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) nombrePerfil = rs.getString("perfil");
        }
        // Actualizar usuario — tabla usuarios, llave idusu
        if (nombrePerfil != null) {
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE usuarios SET id_perfil=? WHERE idusu=?")) {
                ps.setInt(1, idPerfil);
                ps.setInt(2, idUsuario);
                est = ps.executeUpdate();
            }
        }
    } catch (SQLException e) {
        System.out.println("ERROR asignar perfil: " + e.getMessage());
    }
    return est;
}
}
