<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import ="com.oreilly.servlet.*" %>
<%@ page import ="com.oreilly.servlet.multipart.*" %>
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
	
	int maxSize = 1024*1024 * 100; // 100mb
	// 중복된 파일명이 올라와있을 경우 뒤에 숫자를 붙인다 image1.jpg
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	String path = getServletContext().getRealPath("/VueProject/upload");
	MultipartRequest mr = new MultipartRequest(request,path,maxSize,"UTF-8",policy);
	
	int content_idx = Integer.parseInt(mr.getParameter("content_idx"));
	
	String content_subject = mr.getParameter("content_subject");
	String content_text = mr.getParameter("content_text");
	String content_file = mr.getFilesystemName("content_file");
	String sql = "update content_table set content_subject = ?, content_text = ?";
	
	if(content_file!=null){
		sql+=", content_file = ?";
	}
	sql += "where content_idx = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1,content_subject);
	pstmt.setString(2,content_text);
	
	if(content_file!=null){
		pstmt.setString(3,content_file);
		pstmt.setInt(4,content_idx);
	}
	else{
		pstmt.setInt(3,content_idx);
	}
	pstmt.execute();
	
	db.close();
%>
