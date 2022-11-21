package Pack01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class SQL {
	
	
	public static void resultDelete(String voteNm) {
		try {
			String url = IP.url;
            String user = IP.user;
            String pwd = IP.pwd;
			
			PreparedStatement psmt = null;
			Connection con = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user,pwd);
			
			String sql = "delete from vote_result where vote_no = (select vote_no from vote_title where vote_nm = ?)";
		
			psmt = con.prepareStatement(sql);
			psmt.setString(1, voteNm);
			
			psmt.executeUpdate();
			
			psmt.close();
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	}
	
	public static void itemDelete(String voteNm) {
		try {
			String url = IP.url;
            String user = IP.user;
            String pwd = IP.pwd;
			
			PreparedStatement psmt = null;
			Connection con = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user,pwd);
			
			String sql = "delete from vote_item where vote_no = (select vote_no from vote_title where vote_nm = ?)";
		
			psmt = con.prepareStatement(sql);
			psmt.setString(1, voteNm);
			
			psmt.executeUpdate();
			
			sql = "delete from vote_result where vote_no = (select vote_no from vote_title where vote_nm = ?)";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, voteNm);
			
			psmt.executeUpdate();
			
			psmt.close();
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	}
	
	public static void itemInsert(String item, String voteNm) {
		try {
			String url = IP.url;
            String user = IP.user;
            String pwd = IP.pwd;
			
			PreparedStatement psmt = null;
			Connection con = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			con = DriverManager.getConnection(url, user,pwd);
			int vote_no = SQL.selectVoteNo(voteNm);
			
			String sql = "insert into vote_item values(null, ?, ?)";
			
			psmt = con.prepareStatement(sql);
			
			psmt.setInt(1, vote_no);
			psmt.setString(2, item);
			
			psmt.executeUpdate();
			
			psmt.close();
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static int selectVoteNo(String voteNm) {
		try {
			String url = IP.url;
            String user = IP.user;
            String pwd = IP.pwd;
			
			Connection con = null;
			ResultSet rs = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user,pwd);
			
			String sql = "select vote_no from vote_title where vote_nm = '" + voteNm +"'";
			
			Statement stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			
			rs.next();
			
			return rs.getInt(1);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	
	public static void voteInsert(String voteNm) {
		try {
			String url = IP.url;
            String user = IP.user;
            String pwd = IP.pwd;
			
			PreparedStatement psmt = null;
			Connection con = null;
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user,pwd);
			
			
			String sql = "insert into vote_title values(null, ?, true)";
			
			psmt = con.prepareStatement(sql);
			
			psmt.setString(1, voteNm);
			
			psmt.executeUpdate();
			
			
			psmt.close();
			con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
