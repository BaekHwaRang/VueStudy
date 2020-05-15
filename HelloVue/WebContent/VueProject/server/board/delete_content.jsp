<%@page import="java.io.File"%>

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
	
	String f_name_select = "select content_file from content_table where content_idx = ?";
	PreparedStatement f_pstmt = db.prepareStatement(f_name_select);
	f_pstmt.setInt(1, content_idx);
	
	ResultSet f_result = f_pstmt.executeQuery();
	
	f_result.next();
	String path = getServletContext().getRealPath("/VueProject/upload");
	String FileName = f_result.getString("content_file");
	
	File file = new File(path+"/"+FileName);
	if(file.exists()){
		file.delete();
		System.out.println("파일명 : "+FileName+" 이 삭제되었습니다");
	}
	else{
		System.out.println("파일명이 없음");
	}
	
	String sql = "delete from content_table where content_idx = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	
	pstmt.setInt(1, content_idx);
	
	pstmt.execute();
	
	f_pstmt.close();
	f_result.close();
	pstmt.close();
	db.close();
%>
{
	"result" : true
}