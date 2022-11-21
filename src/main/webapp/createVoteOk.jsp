<%@page import="java.util.Objects"%>
<%@page import="Pack01.SQL"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
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
		Object userId = session.getAttribute("id");
		if (Objects.isNull(userId)) {
			response.sendRedirect("login.jsp");
		} else if (!Objects.equals(userId.toString(), "이승철") && !Objects.equals(userId.toString(), "관리자")) {
			response.sendRedirect("voteList.jsp");
		}
		
		request.setCharacterEncoding("UTF-8");
		
		String voteNm = (String)session.getAttribute("voteNm");
		session.removeAttribute("voteNm");
		String[] items = request.getParameterValues("items");
		
		SQL.voteInsert(voteNm);
		
		if (Objects.nonNull(items)) {
			for (String item : items) {
				SQL.itemInsert(item, voteNm);
			}
		}
	%>
	<p> 현재 접속자 :  <%= voteNm %> </p>
	
	<h1><%= voteNm %> 투표가 생성되었습니다.</h1>
	<a href='index.jsp'>처음으로</a>
	
</body>
</html>