<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Other Wishlists</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
    <%@ include file="./dbconn.jsp" %>
    
    <h1>다른 사용자의 위시리스트 검색</h1>
    
    <form id="searchForm">
	    <!-- 검색 옵션 선택 -->
	    <div class="form-row align-items-center">
	        <div class="col-auto">
	            <label class="sr-only" for="searchOption">검색 옵션:</label>
	            <select id="searchOption" class="form-control">
	                <option value="wishlistId">Wishlist ID</option>
	                <option value="wishlistname">Wishlist Name</option>
	                <option value="name">User Name</option>
	            </select>
	        </div>
	        <!-- 검색어 입력 -->
	        <div class="col-auto">
	            <label class="sr-only" for="searchInput">검색어:</label>
	            <input type="text" class="form-control" id="searchInput">
	        </div>
	        <!-- 검색 버튼 -->
	        <div class="col-auto">
	            <button type="button" class="btn btn-primary" onclick="searchOtherWishlists()">검색</button>
	        </div>
	    </div>
	</form>

    <!-- 부트스트랩 테이블 -->
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Wishlist ID</th>
                <th>Wishlist Name</th>
                <th>User Name</th>
            </tr>
        </thead>
        <tbody id="searchResult">
            <!-- 검색 결과가 동적으로 표시될 부분 -->
        </tbody>
    </table>

    <!-- JavaScript 추가 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    
    <script>
	    function searchOtherWishlists() {
	        var searchOption = $("#searchOption").val();
	        var searchInput = $("#searchInput").val();
	
	        // Fetch wishlist data based on the search criteria
	        $.ajax({
	            type: 'POST',
	            url: 'colOtherWishlist.jsp',
	            data: { searchOption: searchOption, searchInput: searchInput },
	            dataType: 'json',
	            success: function (data) {
	                // Clear previous search results
	                $("#searchResult").empty();
	
	                // Populate the table with the fetched data
	                $.each(data, function (index, wishlist) {
	                    var row = '<tr onclick="handleWishlistClick2(\'' + wishlist.wishlistId + '\')">' +
	                        "<td>" + wishlist.wishlistId + "</td>" +
	                        "<td>" + wishlist.wishlistName + "</td>" +
	                        "<td>" + wishlist.userName + "</td>" +
	                        "</tr>";
	                    $("#searchResult").append(row);
	                });
	            },
	            error: function (xhr, status, error) {
	                console.error("Failed to fetch wishlist data. Status: " + status + ", Error: " + error);
	            }
	        });
	    }
	</script>
</body>
</html>