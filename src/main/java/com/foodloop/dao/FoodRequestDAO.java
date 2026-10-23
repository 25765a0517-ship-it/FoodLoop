
package com.foodloop.dao;

import com.foodloop.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FoodRequestDAO {

    /**
     * Creates a food request for an NGO.
     */
    public boolean createRequest(int donationId, int ngoId, int requestedQuantity)
            throws SQLException {

        if (donationId <= 0 || ngoId <= 0 || requestedQuantity <= 0) {
            return false;
        }

        String checkSql =
                "SELECT QUANTITY, STATUS, EXPIRY_TIME " +
                "FROM DONATIONS " +
                "WHERE DONATION_ID = ? " +
                "FOR UPDATE";

        String insertSql =
                "INSERT INTO FOOD_REQUESTS " +
                "(REQUEST_ID, DONATION_ID, NGO_ID, REQUESTED_QUANTITY, STATUS, REQUEST_DATE) " +
                "VALUES (FOOD_REQUESTS_SEQ.NEXTVAL, ?, ?, ?, 'PENDING', CURRENT_TIMESTAMP)";

        try (Connection connection = DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {
                int availableQuantity;
                String donationStatus;
                Timestamp expiryTime;

                try (PreparedStatement checkStatement =
                             connection.prepareStatement(checkSql)) {

                    checkStatement.setInt(1, donationId);

                    try (ResultSet resultSet = checkStatement.executeQuery()) {

                        if (!resultSet.next()) {
                            connection.rollback();
                            return false;
                        }

                        availableQuantity = resultSet.getInt("QUANTITY");
                        donationStatus = resultSet.getString("STATUS");
                        expiryTime = resultSet.getTimestamp("EXPIRY_TIME");
                    }
                }

                if (donationStatus == null
                        || !"AVAILABLE".equalsIgnoreCase(donationStatus)) {
                    connection.rollback();
                    return false;
                }

                if (expiryTime != null
                        && !expiryTime.after(
                                new Timestamp(System.currentTimeMillis()))) {
                    connection.rollback();
                    return false;
                }

                if (requestedQuantity > availableQuantity) {
                    connection.rollback();
                    return false;
                }

                try (PreparedStatement insertStatement =
                             connection.prepareStatement(insertSql)) {

                    insertStatement.setInt(1, donationId);
                    insertStatement.setInt(2, ngoId);
                    insertStatement.setInt(3, requestedQuantity);

                    int rowsInserted = insertStatement.executeUpdate();

                    if (rowsInserted == 1) {
                        connection.commit();
                        return true;
                    } else {
                        connection.rollback();
                        return false;
                    }
                }

            } catch (SQLException e) {
                connection.rollback();
                throw e;
            }
        }
    }

    /**
     * Retrieves all requests for donations belonging to a particular donor.
     */
    public List<Map<String, Object>> getRequestsForDonor(int donorId)
            throws SQLException {

        List<Map<String, Object>> requests =
                new ArrayList<Map<String, Object>>();

        String sql =
                "SELECT FR.REQUEST_ID, " +
                "       FR.DONATION_ID, " +
                "       FR.NGO_ID, " +
                "       FR.REQUESTED_QUANTITY, " +
                "       FR.STATUS, " +
                "       FR.REQUEST_DATE, " +
                "       D.FOOD_NAME " +
                "FROM FOOD_REQUESTS FR " +
                "JOIN DONATIONS D ON FR.DONATION_ID = D.DONATION_ID " +
                "WHERE D.DONOR_ID = ? " +
                "ORDER BY FR.REQUEST_DATE DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, donorId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Map<String, Object> request =
                            new HashMap<String, Object>();

                    request.put("REQUEST_ID",
                            resultSet.getInt("REQUEST_ID"));

                    request.put("DONATION_ID",
                            resultSet.getInt("DONATION_ID"));

                    request.put("NGO_ID",
                            resultSet.getInt("NGO_ID"));

                    request.put("REQUESTED_QUANTITY",
                            resultSet.getInt("REQUESTED_QUANTITY"));

                    request.put("STATUS",
                            resultSet.getString("STATUS"));

                    request.put("REQUEST_DATE",
                            resultSet.getTimestamp("REQUEST_DATE"));

                    request.put("FOOD_NAME",
                            resultSet.getString("FOOD_NAME"));

                    requests.add(request);
                }
            }
        }

        return requests;
    }

    /**
     * Updates a pending request to ACCEPTED or REJECTED.
     * The request must belong to a donation owned by the logged-in donor.
     */
    public boolean updateRequestStatus(
            int requestId,
            int donorId,
            String newStatus) throws SQLException {

        if (requestId <= 0 || donorId <= 0) {
            return false;
        }

        if (newStatus == null
                || (!"ACCEPTED".equals(newStatus)
                && !"REJECTED".equals(newStatus))) {

            throw new IllegalArgumentException(
                    "Status must be ACCEPTED or REJECTED."
            );
        }

        String sql =
                "UPDATE FOOD_REQUESTS " +
                "SET STATUS = ? " +
                "WHERE REQUEST_ID = ? " +
                "AND STATUS = 'PENDING' " +
                "AND EXISTS (" +
                "    SELECT 1 " +
                "    FROM DONATIONS D " +
                "    WHERE D.DONATION_ID = FOOD_REQUESTS.DONATION_ID " +
                "    AND D.DONOR_ID = ?" +
                ")";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, newStatus);
            statement.setInt(2, requestId);
            statement.setInt(3, donorId);

            return statement.executeUpdate() == 1;
        }
    }

    /**
     * Retrieves requests submitted by a particular NGO.
     */
    public List<Map<String, Object>> getRequestsForNgo(int ngoId)
            throws SQLException {

        List<Map<String, Object>> requests =
                new ArrayList<Map<String, Object>>();

        String sql =
                "SELECT FR.REQUEST_ID, " +
                "       FR.DONATION_ID, " +
                "       FR.NGO_ID, " +
                "       FR.REQUESTED_QUANTITY, " +
                "       FR.STATUS, " +
                "       FR.REQUEST_DATE, " +
                "       D.FOOD_NAME " +
                "FROM FOOD_REQUESTS FR " +
                "JOIN DONATIONS D ON FR.DONATION_ID = D.DONATION_ID " +
                "WHERE FR.NGO_ID = ? " +
                "ORDER BY FR.REQUEST_DATE DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, ngoId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Map<String, Object> request =
                            new HashMap<String, Object>();

                    request.put("REQUEST_ID",
                            resultSet.getInt("REQUEST_ID"));

                    request.put("DONATION_ID",
                            resultSet.getInt("DONATION_ID"));

                    request.put("NGO_ID",
                            resultSet.getInt("NGO_ID"));

                    request.put("REQUESTED_QUANTITY",
                            resultSet.getInt("REQUESTED_QUANTITY"));

                    request.put("STATUS",
                            resultSet.getString("STATUS"));

                    request.put("REQUEST_DATE",
                            resultSet.getTimestamp("REQUEST_DATE"));

                    request.put("FOOD_NAME",
                            resultSet.getString("FOOD_NAME"));

                    requests.add(request);
                }
            }
        }

        return requests;
    }

    /**
     * Retrieves NGO requests together with the donor's actual pickup location.
     * Coordinates come from the DONATIONS table.
     */
    public List<Map<String, Object>> getPickupDetailsForNgo(int ngoId)
            throws SQLException {

        List<Map<String, Object>> requests =
                new ArrayList<Map<String, Object>>();

        String sql =
                "SELECT FR.REQUEST_ID, " +
                "       FR.DONATION_ID, " +
                "       FR.NGO_ID, " +
                "       FR.REQUESTED_QUANTITY, " +
                "       FR.STATUS AS REQUEST_STATUS, " +
                "       FR.REQUEST_DATE, " +
                "       D.FOOD_NAME, " +
                "       D.DESCRIPTION, " +
                "       D.QUANTITY AS DONATION_QUANTITY, " +
                "       D.FOOD_TYPE, " +
                "       D.PICKUP_ADDRESS, " +
                "       D.PICKUP_LATITUDE, " +
                "       D.PICKUP_LONGITUDE, " +
                "       D.EXPIRY_TIME, " +
                "       D.DONOR_ID " +
                "FROM FOOD_REQUESTS FR " +
                "JOIN DONATIONS D ON FR.DONATION_ID = D.DONATION_ID " +
                "WHERE FR.NGO_ID = ? " +
                "ORDER BY FR.REQUEST_DATE DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, ngoId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Map<String, Object> request =
                            new HashMap<String, Object>();

                    request.put("REQUEST_ID",
                            resultSet.getInt("REQUEST_ID"));

                    request.put("DONATION_ID",
                            resultSet.getInt("DONATION_ID"));

                    request.put("NGO_ID",
                            resultSet.getInt("NGO_ID"));

                    request.put("REQUESTED_QUANTITY",
                            resultSet.getInt("REQUESTED_QUANTITY"));

                    request.put("STATUS",
                            resultSet.getString("REQUEST_STATUS"));

                    request.put("REQUEST_DATE",
                            resultSet.getTimestamp("REQUEST_DATE"));

                    request.put("FOOD_NAME",
                            resultSet.getString("FOOD_NAME"));

                    request.put("DESCRIPTION",
                            resultSet.getString("DESCRIPTION"));

                    request.put("DONATION_QUANTITY",
                            resultSet.getInt("DONATION_QUANTITY"));

                    request.put("FOOD_TYPE",
                            resultSet.getString("FOOD_TYPE"));

                    request.put("PICKUP_ADDRESS",
                            resultSet.getString("PICKUP_ADDRESS"));

                    request.put("PICKUP_LATITUDE",
                            getNullableDouble(resultSet, "PICKUP_LATITUDE"));

                    request.put("PICKUP_LONGITUDE",
                            getNullableDouble(resultSet, "PICKUP_LONGITUDE"));

                    request.put("EXPIRY_TIME",
                            resultSet.getTimestamp("EXPIRY_TIME"));

                    request.put("DONOR_ID",
                            resultSet.getInt("DONOR_ID"));

                    requests.add(request);
                }
            }
        }

        return requests;
    }

    /**
     * Reads nullable numeric coordinates without converting SQL NULL to zero.
     */
    private Double getNullableDouble(
            ResultSet resultSet,
            String columnName) throws SQLException {

        double value = resultSet.getDouble(columnName);

        if (resultSet.wasNull()) {
            return null;
        }

        return value;
    }
}
