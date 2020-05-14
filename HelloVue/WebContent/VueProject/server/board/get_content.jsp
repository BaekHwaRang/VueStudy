<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import ="com.oreilly.servlet.*" %>
<%@ page import ="com.oreilly.servlet.multipart.*" %>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1522:std";
	String id = "std_user";
	String pw = "1234";
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url,id,pw);
	request.setCharacterEncoding("utf-8");
	int content_idx = Integer.parseInt(request.getParameter("content_idx"));
	String sql = "select a1.content_idx, a1.content_subject, a1.content_text, a1.content_file, "+
			"a1.content_writer_idx, a2.user_name, to_char(a1.content_date,'YYYY-MM-DD') as content_date " + 
			"from content_table a1, user_table a2 "+ 
			"where a1.content_writer_idx = a2.user_idx AND a1.content_idx=?";
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1,content_idx);
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	
	JSONObject root = new JSONObject();
	
	root.put("content_idx",rs.getInt("content_idx"));
	root.put("content_subject",rs.getString("content_subject"));
	root.put("content_text",rs.getString("content_text"));
	root.put("content_file",rs.getString("content_file"));
	root.put("content_writer_idx",rs.getInt("content_writer_idx"));
	root.put("content_writer_name",rs.getString("user_name"));
	root.put("content_date",rs.getString("content_date"));
	
%>
<%= root.toJSONString() %>