package com.foodloop.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:oracle:thin:@localhost:1521:XE";

    private static final String USER = "GOWTHAM";

    private static final String PASSWORD = "manager";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Oracle JDBC driver not found.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void main(String[] args) {
        try (Connection connection = getConnection()) {
            System.out.println("FoodLoop database connected successfully!");
        } catch (SQLException e) {
            System.err.println("Database connection failed!");
            e.printStackTrace();
        }
    }
}