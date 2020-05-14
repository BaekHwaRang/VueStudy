<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>
<%
	Boolean login_chk = (Boolean)session.getAttribute("login_chk");

	if(login_chk == null || login_chk == false){
		return;
	}

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1522:std";
	String id = "std_user";
	String pw = "1234";
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url,id,pw);
	request.setCharacterEncoding("utf-8");
	
	String user_pw = request.getParameter("user_pw");
	String str1 = request.getParameter("user_idx");
	int user_idx = Integer.parseInt(str1);
	
	String sql = "UPDATE USER_TABLE SET USER_PW = ? WHERE USER_IDX = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_pw);
	pstmt.setInt(2, user_idx);
	
	pstmt.execute();
	
	db.close();
	
%>
{
	"result" : true
}	