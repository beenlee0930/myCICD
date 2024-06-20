<!DOCTYPE html>
<html>
<head>
  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Reca3team</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Dongle&family=Noto+Sans+KR&display=swap');
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }
  </style>
</head>
<body>
  <%-- MariaDB 연결 정보 --%>
  <% String url = "jdbc:mariadb://reca3team-prd-mariadb.c1eiqtt31v98.ap-northeast-2.rds.amazonaws.com:3306/MasterpieceDB";
     String username = "admin";
     String password = "Reca3team";
     String driver = "org.mariadb.jdbc.Driver"; %>

  <%@ page import="java.sql.*" %>
  <%@ page import="javax.naming.*" %>
  <%@ page import="javax.sql.*" %>

  <%!
    public Connection getConnection() throws Exception {
      String driver = "org.mariadb.jdbc.Driver";
      String url = "jdbc:mariadb://reca3team-prd-mariadb.c1eiqtt31v98.ap-northeast-2.rds.amazonaws.com:3306/MasterpieceDB";
      String username = "admin";
      String password = "Reca3team";
      Class.forName(driver);
      Connection conn = DriverManager.getConnection(url, username, password);
      return conn;
    }
  %>

  <%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    conn = getConnection();
    stmt = conn.createStatement();
    String sql = "SELECT * FROM Masterpiece";
    rs = stmt.executeQuery(sql);
  %>


<div class="container overflow-hidden text-center">


<nav class="navbar navbar-expand-lg bg-body-tertiary" style="height: 100px;">
  <div class="container-fluid">
    <div>
      <a class="navbar-brand">Reca3team</a>
    </div>
    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page"></a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled"></a>
        </li>
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<ul class="nav">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="#"></a>
  </li>
  <li class="nav-item">
    <a class="nav-link"></a>
  </li>
  <li class="nav-item">
    <a class="nav-link"></a>
  </li>

</ul>


<div class="row row-cols-1 row-cols-md-3 g-4">
  <% while (rs.next()) { %>
    <div class="col">
      <div class="card h-100">
        <img src="<%= rs.getString("url")%>" class="card-img-top">
        <div class="card-body">
          <h3 class="card-title" style="height: 80px;"><%= rs.getString("name") %></h3>
          <p style="height: 10px;"></p>
          <p>artist: <%= rs.getString("artist") %></p>
          <p>type: <%= rs.getString("type") %></p>
          <p>price: <%= rs.getInt("price") %></p>
        </div>
      </div>
    </div>
<% }
   rs.close();
   stmt.close();
   conn.close();
%>


</body>
</html>
