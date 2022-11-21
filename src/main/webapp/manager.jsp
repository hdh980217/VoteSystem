<%@page import="java.util.Objects"%>
<%@page import="Pack01.IP"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
		response.setContentType("text/html; charset=utf-8");

	
		String url = IP.url;
        String user = IP.user;
        String pwd = IP.pwd;
		
		Connection con = null;
		ResultSet rs = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(url, user,pwd);
		
		Statement stmt = con.createStatement();
	    rs = stmt.executeQuery("select * from vote_title;");
	    
	    String voteNm = (String) session.getAttribute("id");
	    
	%>	
	<p> 현재 접속자 :  <%= voteNm %> </p>
	
	<table border='1'>
		<tr>
			<td>투표 제목</td>
			<td>현재 투표 상태</td>
			<td>투표 종료 및 재시작</td>			
			<td>투표 삭제</td>			
			<td>투표 결과</td>			
		</tr>
	<% while(rs.next()) { %>
		<tr>
			<td><%= rs.getString(2) %></td>
			<td><%= rs.getBoolean(3) ? "진행중" : "종료" %></td>
			<% if (rs.getBoolean(3)) { %>
				<td><a href="endVote.jsp?voteNm=<%= rs.getString(2) %>">투표 종료</a></td>
			<%} else {%>
				<td><a href="reStartVote.jsp?voteNm=<%= rs.getString(2) %>">투표 재시작</a></td>
			<%} %>
			<td><a href="deleteVote.jsp?voteNm=<%= rs.getString(2) %>">투표 삭제</a></td>
			<td><a href="voteResult.jsp?no=<%= rs.getString(1) %>">투표 결과</a></td>
		</tr>	
		
	<% } %>
	</table>
	
	<form method="post" action="createVote.jsp">
		<input type="submit" value="투표 만들기">	
	</form>
	
	<form method="post" action="logOut.jsp">
		<input type="submit" value="로그아웃">	
	</form>
	
	<%
		rs.close();
		stmt.close();
		con.close();
	%>
	
</body>
</html>