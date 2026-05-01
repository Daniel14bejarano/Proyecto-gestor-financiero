package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ActividadDAO {

    // Listar actividades asignadas a un perfil (para el menú del dashboard)
    public List<Actividad> listarPorPerfil(String perfil) {
        List<Actividad> lista = new ArrayList<>();
        String q = "SELECT a.id_actividad, a.nom_actividad, a.enlace "
                 + "FROM actividades a "
                 + "JOIN gesActividad g ON a.id_actividad = g.id_actividad "
                 + "JOIN perfiles p ON g.id_perfil = p.id_perfil "
                 + "WHERE p.perfil = ?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {
            ps.setString(1, perfil);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Actividad a = new Actividad();
                a.setIdActividad (rs.getInt   ("id_actividad"));
                a.setNomActividad(rs.getString("nom_actividad"));
                a.setEnlace      (rs.getString("enlace"));
                lista.add(a);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR listarPorPerfil: " + ex.getMessage());
        }
        return lista;
    }

    // Listar todas las actividades registradas
    public List<Actividad> listarTodas() {
        List<Actividad> lista = new ArrayList<>();
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM actividades");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Actividad a = new Actividad();
                a.setIdActividad (rs.getInt   ("id_actividad"));
                a.setNomActividad(rs.getString("nom_actividad"));
                a.setEnlace      (rs.getString("enlace"));
                lista.add(a);
            }
        } catch (SQLException ex) {
            System.out.println("ERROR listarTodas: " + ex.getMessage());
        }
        return lista;
    }

    // Registrar nueva actividad
    public int registrar(Actividad a) {
        int estatus = 0;
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO actividades (nom_actividad, enlace) VALUES (?, ?)")) {
            ps.setString(1, a.getNomActividad());
            ps.setString(2, a.getEnlace());
            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("ERROR registrar actividad: " + ex.getMessage());
        }
        return estatus;
    }

    // Asignar actividad a perfil
    public int asignar(int idPerfil, int idActividad) {
        int estatus = 0;
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO gesActividad (id_perfil, id_actividad) VALUES (?, ?)")) {
            ps.setInt(1, idPerfil);
            ps.setInt(2, idActividad);
            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("ERROR asignar actividad: " + ex.getMessage());
        }
        return estatus;
    }

    // Eliminar actividad
    public int eliminar(int id) {
        int estatus = 0;
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(
                 "DELETE FROM actividades WHERE id_actividad=?")) {
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("ERROR eliminar actividad: " + ex.getMessage());
        }
        return estatus;
    }
}
