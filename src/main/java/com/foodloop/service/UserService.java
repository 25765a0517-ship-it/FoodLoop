
package com.foodloop.service;

import com.foodloop.dao.UserDAO;
import com.foodloop.model.User;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.Base64;
import java.util.regex.Pattern;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
            );

    // Register a new DONOR or NGO.
    public boolean register(User user) throws SQLException {

        if (user == null
                || isBlank(user.getFullName())
                || isBlank(user.getEmail())
                || isBlank(user.getPassword())
                || isBlank(user.getRole())) {

            throw new IllegalArgumentException(
                    "All required fields must be filled.");
        }

        user.setFullName(user.getFullName().trim());
        user.setEmail(user.getEmail().trim().toLowerCase());

        if (!EMAIL_PATTERN.matcher(user.getEmail()).matches()) {
            throw new IllegalArgumentException(
                    "Enter a valid email address.");
        }

        if (user.getPassword().length() < 8) {
            throw new IllegalArgumentException(
                    "Password must contain at least 8 characters.");
        }

        String role = user.getRole().trim().toUpperCase();

        // Public registration must not allow ADMIN accounts.
        if (!role.equals("DONOR") && !role.equals("NGO")) {
            throw new IllegalArgumentException(
                    "Invalid registration role.");
        }

        user.setRole(role);

        if (userDAO.emailExists(user.getEmail())) {
            throw new IllegalArgumentException(
                    "An account with this email already exists.");
        }

        user.setPassword(hashPassword(user.getPassword()));

        return userDAO.registerUser(user);
    }

    // Verify login credentials.
    public User login(String email, String password)
            throws SQLException {

        if (isBlank(email) || isBlank(password)) {
            return null;
        }

        User user = userDAO.findByEmail(email.trim());

        if (user == null
                || !"ACTIVE".equalsIgnoreCase(user.getStatus())) {
            return null;
        }

        if (verifyPassword(password, user.getPassword())) {
            return user;
        }

        return null;
    }

    /*
     * Create an ADMIN account.
     *
     * Call this method only from a trusted, temporary setup program.
     * Do not expose it through a public registration page or servlet.
     */
    public boolean createAdmin(
            String fullName,
            String email,
            String password) throws SQLException {

        if (isBlank(fullName)
                || isBlank(email)
                || isBlank(password)) {

            throw new IllegalArgumentException(
                    "Name, email and password are required.");
        }

        fullName = fullName.trim();
        email = email.trim().toLowerCase();

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            throw new IllegalArgumentException(
                    "Enter a valid email address.");
        }

        if (password.length() < 8) {
            throw new IllegalArgumentException(
                    "Password must contain at least 8 characters.");
        }

        if (userDAO.emailExists(email)) {
            throw new IllegalArgumentException(
                    "An account with this email already exists.");
        }

        User admin = new User();
        admin.setFullName(fullName);
        admin.setEmail(email);
        admin.setPassword(hashPassword(password));
        admin.setPhone(null);
        admin.setRole("ADMIN");

        return userDAO.registerUser(admin);
    }

    // Hash a password using SHA-256 and a random salt.
    // Preserves compatibility with the existing login implementation.
    private String hashPassword(String password) {

        byte[] salt = new byte[16];
        new SecureRandom().nextBytes(salt);

        byte[] hash = sha256(salt, password);

        return "SHA256$"
                + Base64.getEncoder().encodeToString(salt)
                + "$"
                + Base64.getEncoder().encodeToString(hash);
    }

    private boolean verifyPassword(
            String password,
            String storedPassword) {

        if (storedPassword == null) {
            return false;
        }

        try {
            String[] parts = storedPassword.split("\\$");

            if (parts.length != 3
                    || !"SHA256".equals(parts[0])) {
                return false;
            }

            byte[] salt =
                    Base64.getDecoder().decode(parts[1]);

            byte[] expectedHash =
                    Base64.getDecoder().decode(parts[2]);

            byte[] actualHash = sha256(salt, password);

            return MessageDigest.isEqual(
                    expectedHash, actualHash);

        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    private byte[] sha256(byte[] salt, String password) {

        try {
            MessageDigest digest =
                    MessageDigest.getInstance("SHA-256");

            digest.update(salt);

            return digest.digest(
                    password.getBytes(
                            java.nio.charset.StandardCharsets.UTF_8));

        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException(
                    "SHA-256 is unavailable.", e);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
