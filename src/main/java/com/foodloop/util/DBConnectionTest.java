package com.foodloop.util;

import java.sql.Connection;

public class DBConnectionTest {

    public static void main(String[] args) {

        try (Connection connection = DBConnection.getConnection()) {

            System.out.println("FoodLoop database connected successfully!");

        } catch (Exception e) {

            System.out.println("Database connection failed!");
            e.printStackTrace();
        }
    }
}