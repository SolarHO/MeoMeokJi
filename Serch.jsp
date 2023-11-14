<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="MMJ.RestaurantInfo"%>
<%@page import="MMJ.searchApi"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>맛집 검색</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="row justify-content-center">
	    <!-- Search Form -->
	    <form class="form-inline mb-4 col-md-8" method="get" action="">
	        <div class="input-group">
	            <input type="text" class="form-control" name="query" placeholder="검색어를 입력하세요">
	            <div class="input-group-append">
	                <button class="btn btn-primary" type="submit">검색</button>
	            </div>
	        </div>
	    </form>
	</div>

    <%
        String query = request.getParameter("query");
    	searchApi search = new searchApi();
        if (query != null && !query.isEmpty()) {
        	query += " 음식점";
            search.setQuery(query);
            List<RestaurantInfo> restaurantList = search.searchRestaurants();
            // 검색 결과를 Result.jsp에 전달
            request.setAttribute("restaurantList", restaurantList);
        } else {
        	query = "인하대후문 음식점";
        	search.setQuery(query);
        	List<RestaurantInfo> restaurantList = search.searchRestaurants();
            //기본 결과
            request.setAttribute("restaurantList", restaurantList);
        }
    %>

    <!-- Bootstrap JS and jQuery (Make sure to include Popper.js before Bootstrap's JS) -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>