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
	
	String str1 = mr.getParameter("board_writer_idx");
	int board_writer_idx = Integer.parseInt(str1);
	
	String str2 = mr.getParameter("content_board_idx");
	int content_board_idx = Integer.parseInt(str2);
	String board_subject = mr.getParameter("board_subject");
	String board_content = mr.getParameter("board_content");
	String board_file = mr.getFilesystemName("board_file");
	
	String sql = "insert into content_table(content_idx, content_subject, content_text, "+
			"content_file, content_writer_idx, content_board_idx, content_date) "+
			"values(content_seq.nextval,?,?,?,?,?,sysdate)";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, board_subject);
	pstmt.setString(2, board_content);
	pstmt.setString(3, board_file);
	pstmt.setInt(4, board_writer_idx);
	pstmt.setInt(5, content_board_idx);
	pstmt.execute();
	
	// 새롭게 추가된 글의 번호 파악
	
	String sql2 = "select content_seq.currval as content_idx from dual";
	PreparedStatement pstmt2 = db.prepareStatement(sql2);
	
	ResultSet rs2 = pstmt2.executeQuery();
	
	rs2.next();
	int content_idx = rs2.getInt("content_idx");
	
	db.close();
	JSONObject content = new JSONObject();
	content.put("content_idx",content_idx);
%>
{
	"result" : true,
	"content_idx" : <%=content_idx%>
}
