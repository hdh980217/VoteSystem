<%@page import="java.util.Objects"%>
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
	%>


	<% String voteNm = (String) session.getAttribute("id"); %>
	<p> 현재 접속자 :  <%= voteNm %> </p>

	<form method="post" action="createVoteItem.jsp">
		<label>투표 이름</label>
		<input type="text" name="voteNm" required><br/>
		<label>항목 개수</label>
		<input type="number" min="0" max="9999999" name="voteItemNum" required><br/>
		<input type="submit" value="투표 생성">	
	</form>
	<a href='index.jsp'>처음으로</a>
	
</body>
</html>