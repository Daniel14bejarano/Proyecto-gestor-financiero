package modelo;

import java.sql.*;

public class BalanceDAO {

    public Balance obtenerPorUsuario(int idUsuario) {
        Balance b = new Balance();
        try (Connection con = new Conexion().crearConexion(); PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM balances WHERE id_usuario=?")) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                b.setIdBalance(rs.getInt("id_balance"));
                b.setIdUsuario(rs.getInt("id_usuario"));
                b.setTotalIngresos(rs.getDouble("total_ingresos"));
                b.setTotalGastos(rs.getDouble("total_gastos"));
                b.setBalanceActual(rs.getDouble("balance_actual"));
            }
        } catch (SQLException e) {
            System.out.println("ERROR obtener balance: " + e.getMessage());
        }
        return b;
    }
}
