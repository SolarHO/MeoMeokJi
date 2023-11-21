<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>MMJ</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("id") != null) { //로그인이 되어 있을 경우
			userID = (String) session.getAttribute("id");
		}
	%>

<!-- 화면 네비게이션바 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="mmjSearch.jsp">MMJ</a> <!-- 네비게이션바 로고 누르면 메인화면으로 넘어감 -->
    	<%
      	if(userID == null) { // 로그인이 안되어 있을 경우
      	%>
      	<ul class="nav navbar-nav">
        	<li class="dropdown">  <!-- 로그인이 안되어 있는 경우 -->
	        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
	          		<ul class="dropdown-menu">
	            		<li><a href="login.jsp">로그인</a></li>
	            		<li><a href="register.jsp">회원가입</a></li>
	          		</ul>
        	</li>
      	</ul>
      	<%
      		} else {
      	%>
      	<ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">  <!-- 로그인이 되어 있는 경우 -->
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
</script>

</body>
</html>