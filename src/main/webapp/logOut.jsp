<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
	
		out.println("<h1>" + id + "님이 로그아웃 하였습니다." + "</h1>");	
		
	
		session.invalidate();
	%>
	
	<a href='index.jsp'>처음으로</a>
</body>
</html>