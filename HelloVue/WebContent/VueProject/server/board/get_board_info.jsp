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
	
	String sql = "select board_info_idx, board_info_name from board_info_table order by board_info_idx";
	PreparedStatement pstmt = db.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	JSONArray root = new JSONArray();
	
	while(rs.next()){
		JSONObject obj = new JSONObject();
		obj.put("board_info_idx",rs.getInt("board_info_idx"));
		obj.put("board_info_name",rs.getString("board_info_name"));
		
		root.add(obj);
	}
%>
<%= root.toJSONString() %>
<%
	rs.close();
	pstmt.close();
	db.close();
%>
