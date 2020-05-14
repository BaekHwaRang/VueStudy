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
	// 파라미터 한글처리
	request.setCharacterEncoding("utf-8");
	
	String user_name = request.getParameter("user_name");
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	String sql = "insert into user_table (user_idx, user_name ,user_id, user_pw) values(user_seq.nextval,?,?,?)";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_name);
	pstmt.setString(2, user_id);
	pstmt.setString(3, user_pw);
	
	pstmt.execute();
	
%>
{
	"result" : true
}