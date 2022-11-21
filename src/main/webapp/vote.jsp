<%@page import="java.util.Optional"%>
<%@page import="java.util.Objects"%>
<%@page import="Pack01.IP"%>
<%@page import="java.sql.SQLException"%>
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
			} else if (Objects.equals(userId.toString(), "이승철") || Objects.equals(userId.toString(), "관리자")) {
				response.sendRedirect("voteList.jsp");
			}
			
			String url = IP.url;
		    String user = IP.user;
		    String pwd = IP.pwd;
		
			PreparedStatement psmt = null;
			Connection con = null;
			ResultSet rs = null;
			//String voteTitle = request.getParameter("id");
			//String voteNo = request.getParameter("no");
			String voteNm = (String) session.getAttribute("id");
			String voteTitle = Optional.ofNullable(request.getParameter("id")).orElse("no name");
			String voteNo = Optional.ofNullable(request.getParameter("no")).orElse("no No");
			
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, user, pwd);
				System.out.println("success");
				String sql = "SELECT vote_item.item, vote_title.vote_nm, vote_title.vote_no FROM db01.vote_item join vote_title on vote_item.vote_no = vote_title.vote_no where vote_title.vote_nm = ?";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, voteTitle);
				rs = psmt.executeQuery();
		%>
		<p> 현재 접속자 :  <%= voteNm %> </p>		
		
<!-- 			<table border = 1> -->
<!-- 				<tr> -->
<!-- 					<td>투표 이름</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<%-- 					<td><%= votetitle %> --%>
<!-- 				</td> -->
<!-- 			</table> -->

				<form method=post action="voteInsert.jsp" accept-charset="utf-8">
					<h1><%= voteTitle %></h1><br/>
					<%
					while(rs.next()){
					%>	
						<input type="hidden" name="voteNo" value="<%= rs.getString(3)%>"/>
						<input type="radio" name="voteSel" value="<%= rs.getString(1)%>" checked/><%= rs.getString(1)%>
					<%	
					}
					%>
					<input type="submit" value="투표"/>
				</form>

			
		<%
				psmt.close();
				con.close();
			}catch (Exception e) {
				out.println("이미 투표를 하였습니다");
				e.printStackTrace();
			}
		%>
		
		
		
		<a href='index.jsp'>처음으로</a>
</body>
</html>