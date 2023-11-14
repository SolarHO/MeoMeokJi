<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>위시리스트 관리</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">위시리스트 관리</a>
</nav>

<!-- Main Content Area -->
<div class="container-fluid mt-4">
    <div class="row">
        <!-- Left Area (30%) -->
        <div class="col-md-4">
            <!-- Select Box for Wishlist Actions -->
            <div class="form-group">
                <label for="wishlistAction">위시리스트 관리</label>
                <select class="form-control" id="wishlistAction" onchange="loadSelectedPage()">
                    <option value="wishlistSearch.jsp">위시리스트 검색</option>
                    <option value="createWishlist.jsp">위시리스트 생성</option>
                    <option value="editWishlist.jsp">위시리스트 수정</option>
                </select>
            </div>
            <div id="dynamicContent" class="mt-4"></div>
        </div>

        <!-- Right Area (70%) -->
        <div class="col-md-8">
            <!-- Right Area Content Goes Here -->
        </div>
    </div>
</div>

<!-- Bootstrap JS and jQuery (Make sure to include Popper.js before Bootstrap's JS) -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    // Load the selected page when the select box value changes
    function loadSelectedPage() {
        var selectedPage = $("#wishlistAction").val();
        $("#dynamicContent").load(selectedPage);
    }

    // Load the default selected page on page load
    $(document).ready(function () {
        loadSelectedPage();
        
        // Add an event listener to handle changes in the select box
        $("#wishlistAction").change(function() {
            loadSelectedPage();
        });
    });
</script>

</body>
</html>