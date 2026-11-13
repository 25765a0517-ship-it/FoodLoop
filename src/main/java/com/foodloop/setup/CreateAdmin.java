
package com.foodloop.setup;

import com.foodloop.service.UserService;
import java.sql.SQLException;
import java.util.Scanner;

public class CreateAdmin {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        try {
            System.out.println("===== FoodLoop Admin Setup =====");

            System.out.print("Enter admin full name: ");
            String name = scanner.nextLine().trim();

            System.out.print("Enter admin email: ");
            String email = scanner.nextLine().trim();

            System.out.print("Enter admin password (minimum 8 characters): ");
            String password = scanner.nextLine();

            UserService userService = new UserService();

            boolean created = userService.createAdmin(
                    name,
                    email,
                    password
            );

            if (created) {
                System.out.println(
                        "\nSUCCESS: Admin account created!");
                System.out.println("Email: " + email);
                System.out.println(
                        "Now log in using your existing FoodLoop login page.");
            } else {
                System.out.println(
                        "\nAdmin account was not created.");
            }

        } catch (IllegalArgumentException e) {
            System.out.println("\nError: " + e.getMessage());

        } catch (SQLException e) {
            System.out.println(
                    "\nDatabase error: " + e.getMessage());
            e.printStackTrace();

        } finally {
            scanner.close();
        }
    }
}
