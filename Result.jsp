<%@page import="test1.RestaurantInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
</head>
<body>
    <h1>Search Results</h1>
    <table border="1">
        <tr>
            <th>Title</th>
            <th>Link</th>
            <th>Category</th>
            <th>Address</th>
            <th>Latitude</th> <!-- 위도 -->
    		<th>Longitude</th> <!-- 경도 -->
        </tr>
        <%
        List<RestaurantInfo> restaurantList = (List<RestaurantInfo>) request.getAttribute("restaurantList");
        if (restaurantList != null && !restaurantList.isEmpty()) {
            for (RestaurantInfo restaurant : restaurantList) {
        %>
        <tr>
            <td><%= restaurant.getTitle() %></td>
            <td><a href="<%= restaurant.getLink() %>"><%= restaurant.getLink() %></a></td>
            <td><%= restaurant.getCategory() %></td>
            <td><%= restaurant.getAddress() %></td>
            <td><%= restaurant.getMapx() %></td>
            <td><%= restaurant.getMapy() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">No results found.</td>
        </tr>
        <%
        }
        %>
    </table>
</body>
</html>