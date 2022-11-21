<%@ page import="com.mysql.cj.Session" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: coalong
  Date: 2022/11/17
  Time: 4:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
    <head>
        <title>Session Check Page</title>
    </head>
    <body>
        <%-- MEMO: 세션 체크해서 정보 없으면 로그인 페이지로 Redirect, 세션 정보 있으면 알맞는 페이지로 Redirect --%>
        <%
            Object userId = session.getAttribute("id");
            if (Objects.isNull(userId)) {
                response.sendRedirect("login.jsp");
            } else if (Objects.equals(userId.toString(), "이승철") || Objects.equals(userId.toString(), "관리자")) {
                session.setMaxInactiveInterval(1800);
                response.sendRedirect("manager.jsp");
            } else {
                session.setMaxInactiveInterval(600);
                response.sendRedirect("voteList.jsp");
            }
        %>
    </body>
</html>
