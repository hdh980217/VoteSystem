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
		%>
		
		<% String voteNm = (String) session.getAttribute("id");%>
		<p> 현재 접속자 :  <%= voteNm %> </p>		
		
		<%
			request.setCharacterEncoding("UTF-8");
			//String voteSel = request.getParameter("voteSel");
			//int voteNo = Integer.parseInt(request.getParameter("voteNo"));
			
			
			String voteSel = Optional.ofNullable(request.getParameter("voteSel")).orElse("no vote select");
			int voteNo = Integer.parseInt(Optional.ofNullable(request.getParameter("voteNo")).orElse("0"));
			
			String url = IP.url;
	        String user = IP.user;
	        String pwd = IP.pwd;
		
			try {
				PreparedStatement psmt = null;
				Connection con = null;
				ResultSet rs = null;
			
			
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, user, pwd);
				System.out.println("success");
				String sql = "insert into vote_result (id, vote_no, vote_sel) values (?, ?, ?)";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, voteNm);
				psmt.setInt(2, voteNo);
				psmt.setString(3, voteSel);
				psmt.executeUpdate();
				
				psmt.close();
				con.close();
				
				out.println("<h1>투표 완료</h1>");
			}catch (Exception e) {
				PreparedStatement psmt = null;
				Connection con = null;
				ResultSet rs = null;
			
			
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, user, pwd);
				System.out.println("success");
				//UPDATE vote_title SET vote_status = true where vote_nm = ?
				String sql = "UPDATE vote_result set vote_sel = ? where id = ? and vote_no = ?";
				psmt = con.prepareStatement(sql);
				psmt.setString(1, voteSel);
				psmt.setString(2, voteNm);
				psmt.setInt(3, voteNo);
				psmt.executeUpdate();
				
				psmt.close();
				con.close();
				
				
				out.println("<h1>재투표 하였습니다</h1>");
			}
		%>
		<a href='index.jsp'>처음으로</a>
</body>
</html>