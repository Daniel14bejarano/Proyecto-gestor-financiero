package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    public Connection crearConexion() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://localhost:3306/gestor_financiero"
                    + "?useSSL=false&serverTimezone=America/Bogota&allowPublicKeyRetrieval=true";
            con = DriverManager.getConnection(URL, "root", "root");
            System.out.println("Conexion exitosa");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver no encontrado: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error SQL: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }
}
