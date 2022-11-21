<%@page import="Pack01.SQL"%>
<%@page import="java.util.Objects"%>
<%@page import="Pack01.IP"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

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
	            response.sendRedirect("manager.jsp");
	        }
			
			String url = IP.url;
	        String user = IP.user;
	        String pwd = IP.pwd;
		
			PreparedStatement psmt = null;
			Connection con = null;
			ResultSet rs = null;
			
			String voteNm = (String) userId;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, user, pwd);
				System.out.println("success");
				
				
				String sql = "SELECT t.vote_no, t.vote_nm, vote_status, my.id FROM vote_title t	left join vote_result r on r.vote_no = t.vote_no left join (select vote_no, id from vote_result where id = ?) my on r.vote_no = my.vote_no group by t.vote_no;";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, voteNm);
				
				rs = psmt.executeQuery();
				
				
		%>
			<p> 현재 접속자 :  <%= voteNm %> </p>
				<table border = 1>
					<tr>
						<td>투표 이름</td>
						<td>투표하기 및 결과보기</td>
						<td>투표 현황</td>
						<td>투표 유무</td>
					</tr>
		<% 
					while(rs.next()){
						
		%>			
						<tr>
							
							<td> <%= rs.getString(2) %> </td>
							<% if(rs.getBoolean(3)){ %>
									<td> <a href = "vote.jsp?id=<%=rs.getString(2)%>&no=<%= rs.getString(1)%>"> 투표 </a> </td>
									<td> 투표가 진행중 </td>
									
							<%}else {%>		
									<td> <a href = "voteResult.jsp?nm=<%=rs.getString(2)%>&no=<%= rs.getString(1)%>"> 결과보기 </a> </td>
									<td> 투표가 종료됨 </td>								
							<%} %>
							<% if(rs.getString(4) == null){ %>									
									<td> 투표 안했음 </td>
							<%}else {%>									
									<td> 투표 했음 </td>								
							<%} %>
						</tr>
		<% 
					} 
					
		%>
				</table>	
		<%
				psmt.close();
				con.close();
			}catch (Exception e1) {
				e1.printStackTrace();
			}
		%>
		
		<form method="post" action="logOut.jsp">
			<input type="submit" value="로그아웃">	
		</form>
		
</body>
</html>