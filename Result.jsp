<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
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
            	<th>img</th>
                <th>Title</th>
                <th>Link</th>
                <th>Category</th>
            </tr>
        </thead>
        <tbody>
            <%
			List<RestaurantInfo> restaurantList = (List<RestaurantInfo>) request.getAttribute("restaurantList");
			if (restaurantList != null && !restaurantList.isEmpty()) {
			    for (RestaurantInfo restaurant : restaurantList) {
			        String query = restaurant.getTitle(); // Use restaurant title as the query
			        query = query.split("\\s", 2)[0];
			        String imageUrl = null; // Initialize imageUrl for each restaurant
			
			        if (query != null && !query.isEmpty()) {
			            String clientId = "gxCwTW1USgmQU7efK_Dd"; // 네이버 API 클라이언트 아이디
			            String clientSecret = "faEGSpaPfI"; // 네이버 API 클라이언트 시크릿
			
			            try {
			                query = URLEncoder.encode(query, "UTF-8");
			                String apiURL = "https://openapi.naver.com/v1/search/image?query=" + query; // 이미지 검색 API
			                URL url = new URL(apiURL);
			                HttpURLConnection con = (HttpURLConnection) url.openConnection();
			                con.setRequestMethod("GET");
			                con.setRequestProperty("X-Naver-Client-Id", clientId);
			                con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			
			                int responseCode = con.getResponseCode();
			                if (responseCode == 200) { // 정상 호출
			                    BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			                    String inputLine;
			                    StringBuffer Response = new StringBuffer();
			                    while ((inputLine = br.readLine()) != null) {
			                        Response.append(inputLine);
			                    }
			                    br.close();
			
			                    // JSON 데이터 파싱
			                    JSONObject jsonObject = new JSONObject(Response.toString());
			                    JSONArray itemsArray = jsonObject.getJSONArray("items");
			
			                    // 첫 번째 이미지 URL 추출
			                    if (itemsArray.length() > 0) {
			                        JSONObject firstItem = itemsArray.getJSONObject(0);
			                        imageUrl = firstItem.getString("link");
			                    }
			                }
			            } catch (Exception e) {
			                e.printStackTrace();
			            }
			        }
			%>
			<tr onclick="focusOnMap('<%= restaurant.getAddress() %>', '<%= restaurant.getTitle() %>', '<%= restaurant.getCategory() %>');" class="cursor-pointer">
			    <td>
			    <%
			    if(imageUrl != null) {
			    %>
			    <img src="<%= imageUrl %>" width="100" height="100">
			    <%
			    } else {
			    %>
			    <a>대충 고양이 로고</a>
			    <%
			    }
			    %>
			    </td>
			    <td><%= restaurant.getTitle() %></td>
			    <td><a href="<%= restaurant.getLink() %>"><%= restaurant.getLink() %></a></td>
			    <td><%= restaurant.getCategory() %></td>
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