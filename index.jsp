<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Soldesk Project Team</title>
  <style>
    /* 상단 공백 추가 및 이미지 가운데 정렬을 위한 CSS */
    .content {
      padding-top: 20px; /* 상단 공백 추가 */
    }
    .image-container {
      display: flex;
      justify-content: center; /* 이미지 가운데 정렬 */
      margin-bottom: 20px; /* 이미지 사이에 간격 추가 */
    }
    .image-container img {
      max-width: 100%;
      max-width: 800px; /* 이미지 최대 너비 설정 */
    }
  </style>
</head>
<body>

<%-- MySQL 연결 정보 --%>
<%@ page import="java.sql.*" %>

<%! 
  /* 데이터베이스 연결을 위한 메소드 정의 */
  public Connection getConnection() throws Exception {
    String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://sol-rds.c9qa2ga0iatl.ap-northeast-2.rds.amazonaws.com:3306/solmysql_1";
    String username = "admin";
    String password = "soldesk1!";
    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, username, password);
    return conn;
  }
%>

<div class="content">
  <% 
    // 데이터베이스 연결 및 쿼리 실행
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
      // 데이터베이스 연결
      conn = getConnection();
      stmt = conn.createStatement();
      String sql = "SELECT * FROM image_links"; // image_links 테이블에서 데이터 조회
      rs = stmt.executeQuery(sql);

      // 결과 처리 및 이미지 출력
      while (rs.next()) { 
        String imageUrl = rs.getString("image_url"); // 이미지 URL 가져오기
        String hyperlinkUrl = rs.getString("hyperlink_url"); // 하이퍼링크 URL 가져오기
  %>
        <div class="image-container">
          <a href="<%= hyperlinkUrl %>">
            <img src="<%= imageUrl %>" alt="Image">
          </a>
        </div>
  <% 
      }
      // 리소스 닫기
      rs.close();
      stmt.close();
      conn.close();
    } catch (SQLException e) {
      e.printStackTrace(); // SQL 예외 처리
    } catch (Exception e) {
      e.printStackTrace(); // 일반 예외 처리
    }
  %>
</div>

</body>
</html>
