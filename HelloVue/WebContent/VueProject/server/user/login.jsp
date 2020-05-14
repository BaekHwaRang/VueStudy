<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1522:std";
	String id = "std_user";
	String pw = "1234";
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url,id,pw);
	request.setCharacterEncoding("utf-8");
	
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	
	String sql = "select user_idx, user_name from user_table where user_id = ? AND user_pw = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	pstmt.setString(2, user_pw);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean chk = rs.next();
	
	JSONObject root = new JSONObject();
	
	if(chk == false){
		root.put("result",false);
	}else{
		root.put("result",true);
		root.put("user_idx",rs.getInt("user_idx"));
		root.put("user_id",user_id);
		root.put("user_name",rs.getString("user_name"));
		session.setAttribute("login_chk", true);
	}
	db.close();
%>
<%= root.toJSONString() %>
