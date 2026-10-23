package com.foodloop.service;

import com.foodloop.dao.DonationDAO;
import com.foodloop.model.Donation;

import java.sql.SQLException;
import java.time.LocalDateTime;

public class DonationService {

    private final DonationDAO donationDAO;

    public DonationService() {
        this.donationDAO = new DonationDAO();
    }

    // Validate and save a food donation
    public boolean addDonation(Donation donation) throws SQLException {

        // Check whether donation object exists
        if (donation == null) {
            throw new IllegalArgumentException(
                "Donation details are required.");
        }

        // Validate donor ID
        if (donation.getDonorId() <= 0) {
            throw new IllegalArgumentException(
                "Invalid donor ID.");
        }

        // Validate food name
        if (donation.getFoodName() == null
                || donation.getFoodName().trim().isEmpty()) {
            throw new IllegalArgumentException(
                "Food name is required.");
        }

        if (donation.getFoodName().trim().length() > 100) {
            throw new IllegalArgumentException(
                "Food name cannot exceed 100 characters.");
        }

        // Validate quantity
        if (donation.getQuantity() <= 0) {
            throw new IllegalArgumentException(
                "Quantity must be greater than zero.");
        }

        // Validate pickup address
        if (donation.getPickupAddress() == null
                || donation.getPickupAddress().trim().isEmpty()) {
            throw new IllegalArgumentException(
                "Pickup address is required.");
        }

        if (donation.getPickupAddress().trim().length() > 300) {
            throw new IllegalArgumentException(
                "Pickup address cannot exceed 300 characters.");
        }

        // Validate description length
        if (donation.getDescription() != null
                && donation.getDescription().length() > 500) {
            throw new IllegalArgumentException(
                "Description cannot exceed 500 characters.");
        }

        // Validate food type length
        if (donation.getFoodType() != null
                && donation.getFoodType().length() > 50) {
            throw new IllegalArgumentException(
                "Food type cannot exceed 50 characters.");
        }

        // Validate expiry date and time
        if (donation.getExpiryTime() != null
                && !donation.getExpiryTime().toLocalDateTime()
                    .isAfter(LocalDateTime.now())) {
            throw new IllegalArgumentException(
                "Expiry date and time must be in the future.");
        }

        // Trim user-provided text
        donation.setFoodName(donation.getFoodName().trim());
        donation.setPickupAddress(donation.getPickupAddress().trim());

        if (donation.getDescription() != null) {
            donation.setDescription(
                donation.getDescription().trim());
        }

        if (donation.getFoodType() != null) {
            donation.setFoodType(
                donation.getFoodType().trim());
        }

        // Save validated donation through DAO
        return donationDAO.addDonation(donation);
    }
}