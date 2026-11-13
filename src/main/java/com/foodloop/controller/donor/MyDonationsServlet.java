package com.foodloop.controller.donor;

import com.foodloop.dao.DonationDAO;
import com.foodloop.model.Donation;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/donor/my-donations")
public class MyDonationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private DonationDAO donationDAO;

    @Override
    public void init() throws ServletException {
        donationDAO = new DonationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get the existing session without creating a new one
        HttpSession session = request.getSession(false);

        // Check whether the user is logged in
        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        // Check donor role
        String userRole = String.valueOf(
            session.getAttribute("userRole"));

        if (!"DONOR".equalsIgnoreCase(userRole)) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access denied. Only donors can view their donations.");
            return;
        }

        // Retrieve donor ID from the session
        Object id = session.getAttribute("userId");

        if (!(id instanceof Number)) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int donorId = ((Number) id).intValue();

        try {
            // Fetch donations from Oracle Database
            List<Donation> donations =
                donationDAO.getDonationsByDonor(donorId);

            // Pass the donations to the JSP
            request.setAttribute("donations", donations);

            // Forward to the JSP without losing request attributes
            request.getRequestDispatcher(
                "/donor/my-donations.jsp")
                .forward(request, response);

        } catch (SQLException e) {

            getServletContext().log(
                "Unable to retrieve donor donations.", e);

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load donations. Please try again later.");
        }
    }
}