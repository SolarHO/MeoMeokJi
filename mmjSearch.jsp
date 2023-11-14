<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>MMJ</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("id") != null) {
			userID = (String) session.getAttribute("id");
		}
	%>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">MMJ</a>
    	<%
      	if(userID == null) {
      	%>
      	<ul class="nav navbar-nav">
        	<li class="dropdown"><a href="index.jsp">로그인</a></li>
      	</ul>
      	<%
      		} else {
      	%>
      	<ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
          		<ul class="dropdown-menu">
            		<li><a href="logout.jsp">로그아웃</a></li>
            		<li><a href="usermodify.jsp">회원정보 수정</a></li>
          		</ul>
        	</li>
      	</ul>
      	<%
      		}
      	%>
</nav>

<!-- Main Content Area -->
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Left Area (30%) -->
        <div class="col-md-4">
		    <!-- Additional Buttons -->
		    <div class="d-flex justify-content-center mb-2">
		        <div class="btn-group" role="group" aria-label="Basic example">
		            <button type="button" class="btn btn-primary" onclick="searchFunction()">검색</button>
		            <button type="button" class="btn btn-primary" onclick="wishlistFunction()">위시리스트</button>
		            <button type="button" class="btn btn-primary" onclick="randomRecommendationFunction()">랜덤추천</button>
		        </div>
		    </div>
		    <jsp:include page="Serch.jsp" flush="false"/>
		    <jsp:include page="Result.jsp" flush="false"/>
		</div>
        
        <!-- Right Area (70%) -->
        <div class="col-md-8">
            <jsp:include page="map.jsp" flush="false"/>
        </div>
    </div>
</div>

<!-- Bootstrap JS and jQuery (Make sure to include Popper.js before Bootstrap's JS) -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<!-- JavaScript Functions -->
<script>
    function searchFunction() {
    	location.href = 'mmjSearch.jsp';
    }

    function wishlistFunction() {
    	<%
      	if(userID == null) {
      	%>
      	alert('로그인이 필요합니다.');
      	<%
  		} else {
  		%>
  		location.href = 'mmjWishlist.jsp';
  		<%
  		}
  		%>
    }

    function randomRecommendationFunction() {
    	<%
      	if(userID == null) {
      	%>
      	alert('로그인이 필요합니다.');
      	<%
  		} else {
  		%>
  		location.href = 'mmjRandom.jsp';
  		<%
  		}
  		%>
    }
</script>

</body>
</html>