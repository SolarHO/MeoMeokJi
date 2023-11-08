<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>새 위시리스트 생성</h1>
    <form action="createWishlistServlet" method="post">
        위시리스트 이름: <input type="text" name="wlname"><br>
        <h3>카테고리 선택:</h3>
        <c:forEach items="${categories}" var="category">
            <input type="checkbox" name="categories" value="${category.categoryId}"> ${category.categoryName}<br>
        </c:forEach>
        <input type="submit" value="생성">
    </form>
</body>
</html>