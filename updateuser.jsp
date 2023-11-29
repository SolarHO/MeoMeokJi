<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정 결과</title>
</head>
<body>
    <%
    // 폼 데이터 받아오기
    request.setCharacterEncoding("UTF-8");
    String newName = request.getParameter("newName");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    
    // DB 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://mmj.ctjtwbfhskrs.ap-northeast-2.rds.amazonaws.com:3306/MMJ?useUnicode=true&characterEncoding=UTF-8", "meo", "Ska3028!");
        
        // 비밀번호 확인
        if (newPassword.equals(confirmPassword)) {
            // 회원 정보 업데이트
            request.setCharacterEncoding("UTF-8");
            String updateQuery = "UPDATE Users SET name = ?, password = ? WHERE userId = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, newName);
            pstmt.setString(2, newPassword);
            pstmt.setString(3, (String) session.getAttribute("id")); // 세션에서 id 값을 가져와서 설정
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
            	 session.setAttribute("name", newName);
            	response.setContentType("text/html;charset=UTF-8");
        		response.getWriter().println("<script>alert('회원정보가 수정되었습니다. 메인페이지로 이동합니다. '); setTimeout(function(){ window.location.href='index.jsp'; }, 300);</script>");
            } else {
            	response.setContentType("text/html;charset=UTF-8");
        		response.getWriter().println("<script>alert('회원정보 수정에 실패하였습니다. 메인페이지로 이동합니다.'); setTimeout(function(){ window.location.href='index.jsp'; }, 300);</script>");
            }
        } else {
            out.println("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        }
    } catch (Exception e) {
        out.println("오류가 발생하였습니다: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            out.println("자원 해제 오류: " + e.getMessage());
        }
    }
    %>
</body>
</html>