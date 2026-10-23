
package com.foodloop.controller.donor;

import com.foodloop.model.Donation;
import com.foodloop.service.DonationService;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/donor/add-donation")
public class AddDonationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DonationService donationService;

    @Override
    public void init() throws ServletException {
        donationService = new DonationService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || !"DONOR".equalsIgnoreCase(
                    String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher(
            "/donor/add-donation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null
                || !"DONOR".equalsIgnoreCase(
                    String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        Object sessionUserId = session.getAttribute("userId");

        if (!(sessionUserId instanceof Number)) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int donorId = ((Number) sessionUserId).intValue();

        try {
            String foodName = request.getParameter("foodName");
            String description = request.getParameter("description");
            String quantityValue = request.getParameter("quantity");
            String foodType = request.getParameter("foodType");
            String pickupAddress = request.getParameter("pickupAddress");
            String expiryValue = request.getParameter("expiryTime");

            // New fields: pickup coordinates selected on the map
            String latitudeValue =
                request.getParameter("pickupLatitude");

            String longitudeValue =
                request.getParameter("pickupLongitude");

            if (foodName == null || foodName.trim().isEmpty()
                    || quantityValue == null
                    || quantityValue.trim().isEmpty()
                    || pickupAddress == null
                    || pickupAddress.trim().isEmpty()) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/donor/add-donation.jsp?error=missing");
                return;
            }

            int quantity = Integer.parseInt(quantityValue.trim());

            if (quantity <= 0) {
                response.sendRedirect(
                    request.getContextPath()
                    + "/donor/add-donation.jsp?error=quantity");
                return;
            }

            // Parse and validate optional map coordinates
            Double pickupLatitude = null;
            Double pickupLongitude = null;

            boolean latitudeProvided =
                latitudeValue != null && !latitudeValue.trim().isEmpty();

            boolean longitudeProvided =
                longitudeValue != null && !longitudeValue.trim().isEmpty();

            // Both coordinates must be provided together
            if (latitudeProvided != longitudeProvided) {
                response.sendRedirect(
                    request.getContextPath()
                    + "/donor/add-donation.jsp?error=location");
                return;
            }

            if (latitudeProvided) {
                pickupLatitude = Double.parseDouble(latitudeValue.trim());
                pickupLongitude = Double.parseDouble(longitudeValue.trim());

                if (!Double.isFinite(pickupLatitude)
                        || !Double.isFinite(pickupLongitude)
                        || pickupLatitude < -90
                        || pickupLatitude > 90
                        || pickupLongitude < -180
                        || pickupLongitude > 180) {

                    response.sendRedirect(
                        request.getContextPath()
                        + "/donor/add-donation.jsp?error=location");
                    return;
                }
            }

            Donation donation = new Donation();

            donation.setDonorId(donorId);
            donation.setFoodName(foodName.trim());
            donation.setDescription(
                description == null ? "" : description.trim());
            donation.setQuantity(quantity);
            donation.setFoodType(
                foodType == null ? "" : foodType.trim());
            donation.setPickupAddress(pickupAddress.trim());

            // Store selected map coordinates in the Donation model
            donation.setPickupLatitude(pickupLatitude);
            donation.setPickupLongitude(pickupLongitude);

            if (expiryValue != null && !expiryValue.trim().isEmpty()) {
                LocalDateTime expiry =
                    LocalDateTime.parse(expiryValue.trim());

                if (!expiry.isAfter(LocalDateTime.now())) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/donor/add-donation.jsp?error=expiry");
                    return;
                }

                donation.setExpiryTime(
                    java.sql.Timestamp.valueOf(expiry));
            } else {
                donation.setExpiryTime(null);
            }

            boolean saved = donationService.addDonation(donation);

            if (saved) {
                response.sendRedirect(
                    request.getContextPath()
                    + "/donor/my-donations?saved=success");
            } else {
                response.sendRedirect(
                    request.getContextPath()
                    + "/donor/add-donation.jsp?error=save");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath()
                + "/donor/add-donation.jsp?error=location");

        } catch (DateTimeParseException e) {

            response.sendRedirect(
                request.getContextPath()
                + "/donor/add-donation.jsp?error=expiry");

        } catch (SQLException e) {

            getServletContext().log(
                "Error saving food donation.", e);

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to save the donation. Please check the server logs.");
        }
    }
}
