package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
      "jdbc:sqlserver://localhost:1433;"
    + "databaseName=software_ayza_atgawez;"
    + "integratedSecurity=true;"
    + "encrypt=true;"
    + "trustServerCertificate=true;";


    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL);
    }
}
