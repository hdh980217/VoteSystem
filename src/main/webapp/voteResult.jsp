<%@page import="java.util.Optional"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Pack01.IP"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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
			}
		%>
		
		<% //String voteNm = (String) session.getAttribute("id");%>
		
		
		<%
			String url = IP.url;
	        String user = IP.user;
	        String pwd = IP.pwd;
		
			PreparedStatement psmt = null;
			Connection con = null;
			ResultSet rs = null;
			
			String voteNm = Optional.ofNullable((String)session.getAttribute("id")).orElse("no vote name");
			String voteNo = Optional.ofNullable(request.getParameter("no")).orElse("no vote number");
			
			//String voteNo = request.getParameter("no");
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, user, pwd);
				System.out.println("success");
				
				String sql = "select i.item, count(id) from vote_item i left join vote_result r on r.vote_sel = i.item where i.vote_no = ? group by i.vote_item_no order by count(id) desc;";
				
				psmt = con.prepareStatement(sql);
				psmt.setString(1, voteNo);
				rs = psmt.executeQuery();
				
				int sum = 0;
				ArrayList<String> itemList = new ArrayList<>();
				ArrayList<Integer> cntList = new ArrayList<>();
				
				while(rs.next()){
					sum += rs.getInt(2);
					itemList.add(rs.getString(1));
					cntList.add(rs.getInt(2));
				}
		%>
		<p> 현재 접속자 :  <%= voteNm %> </p>
				<table border=1>
					<tr>					
						<td>  순위 </td>
						<td> 항목 </td>
						<td> 투표수 </td>
						<td> 득표율 </td>
					</tr>
		<%			for(int i = 0; i < itemList.size(); i++){
		%>	
						<tr>
							<td> <%= i+1 %> </td>
							<td> <%= itemList.get(i) %> </td>
							<td> <%= cntList.get(i) %> </td>
							<td> <%= String.format("%.1f", (float)cntList.get(i)/(float)((sum == 0) ? 1 : sum)*100) %>% </td>							
						</tr>
						
		<%
		}
		%>		
							
				</table>
				<table border=1>
						<tr>
							<td> 투표자 수 </td>
							<td> <%= sum %> </td>
						</tr>	
						<tr>
							<td> 투표율 </td>
							<td> <%= String.format("%.1f", (float)sum/15.0f*100) %>% </td>
						</tr>
						<tr>
							<td> 총 인원 </td>
							<td> 15 </td>
						</tr>	
				</table>
		<%
				psmt.close();
				con.close();
			}catch (ClassNotFoundException e1) {
				e1.printStackTrace();
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
		%>
		
		<a href='index.jsp'>처음으로</a>
</body>
</html>