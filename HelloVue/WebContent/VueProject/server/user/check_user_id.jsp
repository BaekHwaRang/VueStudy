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
	String sql = "select * from user_table where user_id = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean chk = rs.next();
	
	db.close();
%>
{
	"check_result" : <%= chk %>
}