<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 결과</title>
</head>
<body>
    <%
    // DB 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://mmj.ctjtwbfhskrs.ap-northeast-2.rds.amazonaws.com:3306/MMJ?useUnicode=true&characterEncoding=UTF-8", "meo", "Ska3028!");
        
        // 회원 탈퇴
        String deleteQuery = "DELETE FROM Users WHERE userId = ?";
        pstmt = conn.prepareStatement(deleteQuery);
        pstmt.setString(1, (String) session.getAttribute("id")); // 세션에서 id 값을 가져와서 설정
        
        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected > 0) {
            out.println("회원 탈퇴가 완료되었습니다.");
            // 세션을 종료하여 로그아웃 상태로 변경
            response.setContentType("text/html;charset=UTF-8");
    		response.getWriter().println("<script>alert('회원탈퇴되었습니다 행복하세요.'); setTimeout(function(){ window.location.href='logout.jsp'; }, 300);</script>");
        } else {
            out.println("회원 탈퇴에 실패하였습니다.");
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