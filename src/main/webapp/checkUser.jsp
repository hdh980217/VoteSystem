<%--
  Created by IntelliJ IDEA.
  User: coalong
  Date: 2022/11/17
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="Pack01.IP"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- MEMO: 필요한 설정 import --%>
<%@ page import="java.sql.Connection"
         import="java.sql.DriverManager"
         import="java.sql.SQLException"
%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.Objects" %>
<%-- MEMO: 한글 인코딩 설정 --%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
    <head>
        <title>CheckUser Page</title>
    </head>
    <body>

        <%!
            boolean checkUser(String id, String pw) {
                String url = IP.url;
                String user = IP.user;
                String pwd = IP.pwd;
                Connection connection;
                ResultSet rs;

                // MEMO: DB Connection
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, user, pwd);
                } catch (SQLException | ClassNotFoundException e) {
                    throw new RuntimeException(e);
                }

                // MEMO: 아이디 비번 체크
                // MEMO: 사용자 유효성 체크 후 return
                String query = "SELECT * FROM member WHERE id = ?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, id);
                    rs = statement.executeQuery();
                    if (rs.next() && Objects.equals(String.valueOf(rs.getInt("pw")), pw)) {
                        return true;
                    } else return false;
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        %>

        <%
            String id = request.getParameter("id");
            String pw = request.getParameter("pw");

            //MEMO: 로그인 실패시 예외 페이지로 redirect
            //MEMO: 로그인 성공시 세션 저장 후 페이지 Redirect
            if (checkUser(id, pw)) {
                session.setAttribute("id", id);
                if (id.equals("이승철") || id.equals("관리자")) {
                    session.setMaxInactiveInterval(1800);
                    response.sendRedirect("manager.jsp");
                } else {
                    session.setMaxInactiveInterval(600);
                    response.sendRedirect("voteList.jsp");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
    </body>
</html>
