
package com.foodloop.dao;

import com.foodloop.model.Donation;
import com.foodloop.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class DonationDAO {

    // Save a new food donation to Oracle Database
    public boolean addDonation(Donation donation) throws SQLException {

        String sql =
            "INSERT INTO DONATIONS " +
            "(DONATION_ID, DONOR_ID, FOOD_NAME, DESCRIPTION, " +
            "QUANTITY, FOOD_TYPE, PICKUP_ADDRESS, PICKUP_LATITUDE, " +
            "PICKUP_LONGITUDE, EXPIRY_TIME, STATUS, CREATED_AT) " +
            "VALUES (DONATIONS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
            "'AVAILABLE', CURRENT_TIMESTAMP)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, donation.getDonorId());
            ps.setString(2, donation.getFoodName());
            ps.setString(3, donation.getDescription());
            ps.setInt(4, donation.getQuantity());
            ps.setString(5, donation.getFoodType());
            ps.setString(6, donation.getPickupAddress());

            if (donation.getPickupLatitude() != null) {
                ps.setDouble(7, donation.getPickupLatitude());
            } else {
                ps.setNull(7, Types.DOUBLE);
            }

            if (donation.getPickupLongitude() != null) {
                ps.setDouble(8, donation.getPickupLongitude());
            } else {
                ps.setNull(8, Types.DOUBLE);
            }

            if (donation.getExpiryTime() != null) {
                ps.setTimestamp(9, donation.getExpiryTime());
            } else {
                ps.setNull(9, Types.TIMESTAMP);
            }

            return ps.executeUpdate() == 1;
        }
    }

    // Retrieve all donations belonging to a particular donor
    public List<Donation> getDonationsByDonor(int donorId)
            throws SQLException {

        List<Donation> donations = new ArrayList<>();

        String sql =
            "SELECT DONATION_ID, DONOR_ID, FOOD_NAME, DESCRIPTION, " +
            "QUANTITY, FOOD_TYPE, PICKUP_ADDRESS, PICKUP_LATITUDE, " +
            "PICKUP_LONGITUDE, EXPIRY_TIME, STATUS " +
            "FROM DONATIONS " +
            "WHERE DONOR_ID = ? " +
            "ORDER BY CREATED_AT DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, donorId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    donations.add(mapDonation(rs));
                }
            }
        }

        return donations;
    }

    // Retrieve all available donations for the NGO dashboard
    public List<Donation> getAvailableDonations()
            throws SQLException {

        List<Donation> donations = new ArrayList<>();

        String sql =
            "SELECT DONATION_ID, DONOR_ID, FOOD_NAME, DESCRIPTION, " +
            "QUANTITY, FOOD_TYPE, PICKUP_ADDRESS, PICKUP_LATITUDE, " +
            "PICKUP_LONGITUDE, EXPIRY_TIME, STATUS " +
            "FROM DONATIONS " +
            "WHERE STATUS = 'AVAILABLE' " +
            "AND (EXPIRY_TIME IS NULL " +
            "OR EXPIRY_TIME > CURRENT_TIMESTAMP) " +
            "ORDER BY CREATED_AT DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                donations.add(mapDonation(rs));
            }
        }

        return donations;
    }

    // Retrieve one available donation using its ID
    public Donation getAvailableDonationById(int donationId)
            throws SQLException {

        String sql =
            "SELECT DONATION_ID, DONOR_ID, FOOD_NAME, DESCRIPTION, " +
            "QUANTITY, FOOD_TYPE, PICKUP_ADDRESS, PICKUP_LATITUDE, " +
            "PICKUP_LONGITUDE, EXPIRY_TIME, STATUS " +
            "FROM DONATIONS " +
            "WHERE DONATION_ID = ? " +
            "AND STATUS = 'AVAILABLE' " +
            "AND (EXPIRY_TIME IS NULL " +
            "OR EXPIRY_TIME > CURRENT_TIMESTAMP)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, donationId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDonation(rs);
                }
            }
        }

        return null;
    }

    // Retrieve a donation belonging to a specific donor for editing
    public Donation getDonationByIdForDonor(int donationId, int donorId)
            throws SQLException {

        String sql =
            "SELECT DONATION_ID, DONOR_ID, FOOD_NAME, DESCRIPTION, " +
            "QUANTITY, FOOD_TYPE, PICKUP_ADDRESS, PICKUP_LATITUDE, " +
            "PICKUP_LONGITUDE, EXPIRY_TIME, STATUS " +
            "FROM DONATIONS " +
            "WHERE DONATION_ID = ? AND DONOR_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, donationId);
            ps.setInt(2, donorId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapDonation(rs);
                }
            }
        }

        return null;
    }

    // Update an existing donation owned by the logged-in donor
    public boolean updateDonation(Donation donation, int donorId)
            throws SQLException {

        if (donation == null
                || donation.getDonationId() <= 0
                || donorId <= 0) {
            return false;
        }

        String sql =
            "UPDATE DONATIONS SET " +
            "FOOD_NAME = ?, DESCRIPTION = ?, QUANTITY = ?, " +
            "FOOD_TYPE = ?, PICKUP_ADDRESS = ?, PICKUP_LATITUDE = ?, " +
            "PICKUP_LONGITUDE = ?, EXPIRY_TIME = ? " +
            "WHERE DONATION_ID = ? AND DONOR_ID = ? " +
            "AND STATUS = 'AVAILABLE'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, donation.getFoodName());
            ps.setString(2, donation.getDescription());
            ps.setInt(3, donation.getQuantity());
            ps.setString(4, donation.getFoodType());
            ps.setString(5, donation.getPickupAddress());

            if (donation.getPickupLatitude() != null) {
                ps.setDouble(6, donation.getPickupLatitude());
            } else {
                ps.setNull(6, Types.DOUBLE);
            }

            if (donation.getPickupLongitude() != null) {
                ps.setDouble(7, donation.getPickupLongitude());
            } else {
                ps.setNull(7, Types.DOUBLE);
            }

            if (donation.getExpiryTime() != null) {
                ps.setTimestamp(8, donation.getExpiryTime());
            } else {
                ps.setNull(8, Types.TIMESTAMP);
            }

            ps.setInt(9, donation.getDonationId());
            ps.setInt(10, donorId);

            return ps.executeUpdate() == 1;
        }
    }

    // Retrieve ALL donations for the Admin dashboard.
    // Includes all statuses and expired donations.
    public List<Donation> getAllDonations() throws SQLException {

        List<Donation> donations = new ArrayList<>();

        String sql =
            "SELECT DONATION_ID, DONOR_ID, FOOD_NAME, DESCRIPTION, " +
            "QUANTITY, FOOD_TYPE, PICKUP_ADDRESS, PICKUP_LATITUDE, " +
            "PICKUP_LONGITUDE, EXPIRY_TIME, STATUS " +
            "FROM DONATIONS " +
            "ORDER BY DONATION_ID DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                donations.add(mapDonation(rs));
            }
        }

        return donations;
    }

    /*
     * Permanently delete a donation as an admin operation.
     *
     * FOOD_REQUESTS has a foreign key to DONATIONS, so its related
     * request records must be removed first.
     *
     * Both operations use one transaction:
     * - If both deletes succeed, commit.
     * - If the donation does not exist or either delete fails, rollback.
     *
     * Note: related FOOD_REQUESTS history is also deleted.
     */
    public boolean deleteDonationByAdmin(int donationId)
            throws SQLException {

        if (donationId <= 0) {
            return false;
        }

        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // Confirm the donation exists and lock it for this transaction.
            String checkSql =
                "SELECT DONATION_ID FROM DONATIONS " +
                "WHERE DONATION_ID = ? FOR UPDATE";

            try (PreparedStatement checkPs =
                    con.prepareStatement(checkSql)) {

                checkPs.setInt(1, donationId);

                try (ResultSet rs = checkPs.executeQuery()) {
                    if (!rs.next()) {
                        con.rollback();
                        return false;
                    }
                }
            }

            // Remove requests referencing this donation first.
            String deleteRequestsSql =
                "DELETE FROM FOOD_REQUESTS WHERE DONATION_ID = ?";

            try (PreparedStatement requestPs =
                    con.prepareStatement(deleteRequestsSql)) {

                requestPs.setInt(1, donationId);
                requestPs.executeUpdate();
            }

            // Now delete the donation itself.
            String deleteDonationSql =
                "DELETE FROM DONATIONS WHERE DONATION_ID = ?";

            int deletedRows;

            try (PreparedStatement donationPs =
                    con.prepareStatement(deleteDonationSql)) {

                donationPs.setInt(1, donationId);
                deletedRows = donationPs.executeUpdate();
            }

            if (deletedRows != 1) {
                con.rollback();
                return false;
            }

            con.commit();
            return true;

        } catch (SQLException e) {

            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException rollbackException) {
                    e.addSuppressed(rollbackException);
                }
            }

            throw e;

        } finally {

            if (con != null) {
                try {
                    con.setAutoCommit(true);
                } catch (SQLException ignored) {
                    // The connection is closed immediately afterward.
                }

                try {
                    con.close();
                } catch (SQLException ignored) {
                    // Do not hide the original database result.
                }
            }
        }
    }

    // Map one database row to a Donation object
    private Donation mapDonation(ResultSet rs) throws SQLException {

        Donation donation = new Donation();

        donation.setDonationId(rs.getInt("DONATION_ID"));
        donation.setDonorId(rs.getInt("DONOR_ID"));
        donation.setFoodName(rs.getString("FOOD_NAME"));
        donation.setDescription(rs.getString("DESCRIPTION"));
        donation.setQuantity(rs.getInt("QUANTITY"));
        donation.setFoodType(rs.getString("FOOD_TYPE"));
        donation.setPickupAddress(rs.getString("PICKUP_ADDRESS"));
        donation.setPickupLatitude(
            getNullableDouble(rs, "PICKUP_LATITUDE"));
        donation.setPickupLongitude(
            getNullableDouble(rs, "PICKUP_LONGITUDE"));
        donation.setExpiryTime(rs.getTimestamp("EXPIRY_TIME"));
        donation.setStatus(rs.getString("STATUS"));

        return donation;
    }

    // Read nullable Oracle coordinates without converting NULL to 0
    private Double getNullableDouble(ResultSet rs, String columnName)
            throws SQLException {

        double value = rs.getDouble(columnName);

        if (rs.wasNull()) {
            return null;
        }

        return value;
    }
}
