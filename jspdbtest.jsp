<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MySQL 연동 예제</title>
</head>
<body>
    <% 
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://mmj.ctjtwbfhskrs.ap-northeast-2.rds.amazonaws.com:3306", "meo", "Ska3028!");
        out.println("연결 성공!");
        
        String useDatabaseSQL = "USE MMJ";
        stmt = conn.createStatement();
        stmt.execute(useDatabaseSQL); // 여기서 YourDatabaseName을 실제 데이터베이스 이름으로 바꿔야 합니다.

        // SELECT 문을 실행하여 Users 테이블의 모든 정보를 가져옵니다.
        String sql = "SELECT * FROM Users";
        rs = stmt.executeQuery(sql);
        
        // 결과 출력
        while (rs.next()) {
            out.println("ID: " + rs.getString("userId") + "<br>");
            out.println("비밀번호: " + rs.getString("password") + "<br>");
            out.println("이름: " + rs.getString("name") + "<br>");
            out.println("이메일: " + rs.getString("email") + "<br><br>");
        }
    } catch (Exception e) {
        out.println("연결 실패: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
    
</body>
</html>