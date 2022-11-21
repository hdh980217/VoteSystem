<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: coalong
  Date: 2022/11/17
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
    <head>
        <title>Login Page</title>
    </head>
    <body>
        <%
            Object userId = session.getAttribute("id");
            if (Objects.nonNull(userId)) {
                response.sendRedirect("index.jsp");
            }
        %>
        <form method="post" action="checkUser.jsp">
            아이디 <input type="text" name="id" required/> <br>
            비밀번호 <input type="password" name="pw" required/> <br>
            <input type="submit" value="로그인">
        </form>
    </body>
</html>
