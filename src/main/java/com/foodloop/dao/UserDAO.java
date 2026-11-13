
package com.foodloop.dao;

import com.foodloop.model.User;
import com.foodloop.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Check whether an email already exists.
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT USER_ID FROM USERS WHERE LOWER(EMAIL) = LOWER(?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Register a new user.
    // The password must already be securely hashed by UserService.
    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO USERS "
                + "(USER_ID, FULL_NAME, EMAIL, PASSWORD, PHONE, ROLE, STATUS) "
                + "VALUES (USERS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, 'ACTIVE')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());

            return ps.executeUpdate() == 1;
        }
    }

    // Find an active user by email for login.
    // Deactivated accounts are not returned.
    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT USER_ID, FULL_NAME, EMAIL, PASSWORD, "
                + "PHONE, ROLE, STATUS, CREATED_AT "
                + "FROM USERS "
                + "WHERE LOWER(EMAIL) = LOWER(?) "
                + "AND (STATUS IS NULL OR UPPER(STATUS) = 'ACTIVE')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }

        return null;
    }

    // Find a user by ID.
    public User findById(int userId) throws SQLException {
        String sql = "SELECT USER_ID, FULL_NAME, EMAIL, PASSWORD, "
                + "PHONE, ROLE, STATUS, CREATED_AT "
                + "FROM USERS WHERE USER_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }

        return null;
    }

    // Get registered accounts for the admin Manage Users screen.
    // Deactivated accounts are excluded.
    public List<User> findAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();

        String sql = "SELECT USER_ID, FULL_NAME, EMAIL, "
                + "PHONE, ROLE, STATUS, CREATED_AT "
                + "FROM USERS "
                + "WHERE STATUS IS NULL OR UPPER(STATUS) <> 'DELETED' "
                + "ORDER BY USER_ID DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();

                user.setUserId(rs.getInt("USER_ID"));
                user.setFullName(rs.getString("FULL_NAME"));
                user.setEmail(rs.getString("EMAIL"));
                user.setPhone(rs.getString("PHONE"));
                user.setRole(rs.getString("ROLE"));
                user.setStatus(rs.getString("STATUS"));
                user.setCreatedAt(rs.getTimestamp("CREATED_AT"));

                users.add(user);
            }
        }

        return users;
    }

    // Deactivate an account without deleting its related donations,
    // food requests, or pickup history.
    // Admin accounts cannot be deactivated through this method.
    public boolean deleteUserByAdmin(int userId) throws SQLException {
        if (userId <= 0) {
            return false;
        }

        String sql = "UPDATE USERS SET STATUS = 'DELETED' "
                + "WHERE USER_ID = ? "
                + "AND UPPER(ROLE) <> 'ADMIN' "
                + "AND (STATUS IS NULL OR UPPER(STATUS) <> 'DELETED')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() == 1;
        }
    }

    // Map a database row to the existing User model.
    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();

        user.setUserId(rs.getInt("USER_ID"));
        user.setFullName(rs.getString("FULL_NAME"));
        user.setEmail(rs.getString("EMAIL"));
        user.setPassword(rs.getString("PASSWORD"));
        user.setPhone(rs.getString("PHONE"));
        user.setRole(rs.getString("ROLE"));
        user.setStatus(rs.getString("STATUS"));
        user.setCreatedAt(rs.getTimestamp("CREATED_AT"));

        return user;
    }
}
