<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		} else {
	%>
		<script>
			location.href = 'mmjSearch.jsp';
		</script>
	<%		
		}
	%>

<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">MMJ</a>
    	<ul class="nav navbar-nav navbar-right">
        	<li class="dropdown">
          		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
          		<ul class="dropdown-menu">
            		<li><a href="logout.jsp">로그아웃</a></li>
            		<li><a href="usermodify.jsp">회원정보 수정</a></li>
          		</ul>
        	</li>
      	</ul>
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

                <!-- Select Box for Wishlist Actions -->
                <div class="form-group">
                    <select class="form-control" id="wishlistAction" onchange="loadSelectedPage()">
                        <option value="selectMyWishlist.jsp">위시리스트 검색</option>
                        <option value="createWishlist.jsp">위시리스트 생성</option>
                        <option value="editWishlist.jsp">위시리스트 수정</option>
                    </select>
                </div>
                <div id="dynamicContent" class="mt-4"></div>
            </div>
            <!-- Right Area (70%) -->
            <div class="col-md-8">
                <jsp:include page="map.jsp" flush="false"/>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and jQuery (Make sure to include Popper.js before Bootstrap's JS) -->
    <!-- Bootstrap JS와 jQuery를 포함하기 (jQuery를 Bootstrap JS보다 먼저 포함) -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
	<!-- Bootstrap 토글 버튼 관련 스크립트 추가 -->
	<script>
	    $(document).ready(function () {
	        $('.btn-group-toggle .btn').on('click', function () {
	            $(this).toggleClass('active');
	        });
	    });
	    function searchFunction() {
	        location.href = 'mmjSearch.jsp';
	    }
	
	    function wishlistFunction() {
	        location.href = 'mmjWishlist.jsp';
	    }
	    
	    
	    // Load the selected page when the select box value changes using Ajax
	    function loadSelectedPage() {
	        var selectedPage = $("#wishlistAction").val();
	
	        $.ajax({
	            type: 'GET',
	            url: selectedPage,
	            success: function (response) {
	                // Update the dynamicContent area with the loaded content
	                $("#dynamicContent").html(response);
	            },
	            error: function (xhr, status, error) {
	                console.error("Failed to load the selected page. Status: " + status + ", Error: " + error);
	            }
	        });
	    }
	
	    // Load the default selected page on page load
	    $(document).ready(function () {
	        loadSelectedPage();
	
	        // Add an event listener to handle changes in the select box
	        $("#wishlistAction").change(function () {
	            loadSelectedPage();
	        });
	    });
	
	    function handleWishlistClick(wishlistId) {
	        $.ajax({
	            type: 'POST',
	            url: 'saveMyWishlistID.jsp',
	            data: { selectedWishlistId: wishlistId },
	            success: function () {
	            	loaddynamicPage("selectOtherWishlist.jsp");
	            },
	            error: function (xhr, status, error) {
	                console.error("Failed to save selected wishlistId in session. Status: " + status + ", Error: " + error);
	            }
	        });
	    }
	    
	    function loaddynamicPage(page) {
	        $.ajax({
	            type: 'GET',
	            url: page,
	            success: function (response) {
	                // Update the dynamicContent area with the loaded content
	                $("#dynamicContent").html(response);
	            },
	            error: function (xhr, status, error) {
	                console.error("Failed to load the selected page. Status: " + status + ", Error: " + error);
	            }
	        });
	    }
	    function loadResultPage(page) {
	        $.ajax({
	            type: 'GET',
	            url: page,
	            success: function (response) {
	                // Update the dynamicContent area with the loaded content
	                $("#dynamicContent").html(response);
	            },
	            error: function (xhr, status, error) {
	                console.error("Failed to load the selected page. Status: " + status + ", Error: " + error);
	            }
	        });
	    }
	    
	    function handleWishlistClick2(wishlistId) {
	        // Save the selected wishlistId in session
	        $.ajax({
	            type: 'POST',
	            url: 'saveOtherWishlist.jsp',
	            data: { selectedWishlistId: wishlistId },
	            success: function () {
	            	location.href = 'mmjSearch.jsp';
	            },
	            error: function (xhr, status, error) {
	                console.error("Failed to save selected wishlistId in session. Status: " + status + ", Error: " + error);
	            }
	        });
	    }
	</script>

</body>
</html>