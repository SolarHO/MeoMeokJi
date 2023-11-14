<%@page import="MMJ.RestaurantInfo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            padding-top: 56px;
        }

        .map-container {
            height: 500px; /* Set an appropriate height for the map container */
        }

        .selected-row {
            background-color: #e0e0e0; /* Set a background color for the selected row */
        }
    </style>
</head>
<body>

<div class="container mt-4">
    <h1>검색 결과</h1>
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr>
                <th>Title</th>
                <th>Link</th>
                <th>Category</th>
                <th>Address</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<RestaurantInfo> restaurantList = (List<RestaurantInfo>) request.getAttribute("restaurantList");
                if (restaurantList != null && !restaurantList.isEmpty()) {
                    for (RestaurantInfo restaurant : restaurantList) {
            %>
            <tr onclick="focusOnMap('<%= restaurant.getAddress() %>', '<%= restaurant.getTitle() %>', '<%= restaurant.getCategory() %>');" class="cursor-pointer">
                <td><%= restaurant.getTitle() %></td>
                <td><a href="<%= restaurant.getLink() %>"><%= restaurant.getLink() %></a></td>
                <td><%= restaurant.getCategory() %></td>
                <td><%= restaurant.getAddress() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4">검색 결과가 없습니다.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS and jQuery (Make sure to include Popper.js before Bootstrap's JS) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- JavaScript Function to Focus on Map -->
<script>
    function focusOnMap(address, title, category) {
        // Your code to focus on the map with the given address, title, and category
        alert('Focusing on the map for:\nTitle: ' + title + '\nCategory: ' + category + '\nAddress: ' + address);
        // Add code here to focus on the map using the provided address, title, and category
    }
</script>

</body>
</html>