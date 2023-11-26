<%@page import="java.io.Console"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Get the selected wishlistId from the request
    String selectedWishlistId = request.getParameter("selectedWishlistId");

    // Save the selected wishlistId in session
    session.setAttribute("myWishlist", selectedWishlistId);
    Console console = System.console();
    if (console != null) {
        console.writer().println("WishlistId saved in session: " + selectedWishlistId);
    } else {
        System.out.println("WishlistId saved in session: " + selectedWishlistId);
    }
%>