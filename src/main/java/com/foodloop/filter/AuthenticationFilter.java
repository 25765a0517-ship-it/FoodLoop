package com.foodloop.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    private static final Set<String> PUBLIC_PATHS = new HashSet<>(
        Arrays.asList(
            "/",
            "/index.html",
            "/login.jsp",
            "/register.jsp",
            "/login",
            "/register",
            "/logout",
            "/favicon.ico"
        )
    );

    @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {
        // No initialization required.
    }

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI()
                         .substring(req.getContextPath().length());

        // Allow public pages and frontend resources.
        if (isPublicPath(path) || isStaticResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String role = (String) session.getAttribute("userRole");

        if (role == null || !hasRequiredRole(path, role)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN,
                          "You are not authorized to access this page.");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicPath(String path) {
        return PUBLIC_PATHS.contains(path);
    }

    private boolean isStaticResource(String path) {
        String lower = path.toLowerCase();

        return lower.startsWith("/css/")
            || lower.startsWith("/js/")
            || lower.startsWith("/images/")
            || lower.endsWith(".png")
            || lower.endsWith(".jpg")
            || lower.endsWith(".jpeg")
            || lower.endsWith(".gif")
            || lower.endsWith(".svg")
            || lower.endsWith(".ico");
    }

    private boolean hasRequiredRole(String path, String role) {
        String normalizedRole = role.toUpperCase();

        if (path.startsWith("/admin/")) {
            return "ADMIN".equals(normalizedRole);
        }

        if (path.startsWith("/donor/")) {
            return "DONOR".equals(normalizedRole);
        }

        if (path.startsWith("/ngo/")) {
            return "NGO".equals(normalizedRole);
        }

        return true;
    }

    @Override
    public void destroy() {
        // No resources to release.
    }
}