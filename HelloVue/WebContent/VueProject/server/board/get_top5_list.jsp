<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>
<%
	/* Boolean login_chk = (Boolean)session.getAttribute("login_chk");

	if(login_chk == null || login_chk == false){
		return;
	} */
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1522:std";
	String id = "std_user";
	String pw = "1234";
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url,id,pw);
	request.setCharacterEncoding("utf-8");
	
	String str1 = request.getParameter("board_idx");
	int board_idx = Integer.parseInt(str1);
	
	String sql = "select board_info_name from board_info_table where board_info_idx = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, board_idx);
	ResultSet rs = pstmt.executeQuery();
	
	JSONObject root = new JSONObject();
	rs.next();
	
	String board_info_name = rs.getString("board_info_name");
	
	root.put("board_info_name",board_info_name);
	
	//게시글 목록 가져오기
	/* String sql2 = ""+
	"select a1.content_idx, a1.content_subject,"+
	"to_char(a1.content_date, 'YYYY-MM-DD') as content_date, a2.USER_NAME"+
	" from  content_table a1 , user_table a2"+
	" where a1.content_writer_idx = a2.user_idx AND a1.content_board_idx = ?"+
	" order by a1.content_idx desc"; */
	
	String sql2 = "select p2.* from "+
	" (select rownum as num, p1.* from "+ 
	" (select a1.content_idx, a1.content_subject, "+
	" to_char(a1.content_date, 'YYYY-MM-DD') as content_date, a2.USER_NAME "+
	" from  content_table a1 , user_table a2 "+
	" where a1.content_writer_idx = a2.user_idx AND a1.content_board_idx = ? "+
	" order by a1.CONTENT_IDX desc) p1) p2 "+
	" where p2.num>=1 and p2.num<=5 ";
	
	PreparedStatement pstmt2 = db.prepareStatement(sql2);
	pstmt2.setInt(1, board_idx);
	ResultSet rs2 = pstmt2.executeQuery();
	
	JSONArray board_list = new JSONArray();
	while(rs2.next()){
		JSONObject obj = new JSONObject();
		obj.put("content_idx",rs2.getInt("content_idx"));
		obj.put("content_subject",rs2.getString("content_subject"));
		obj.put("content_writer_name",rs2.getString("user_name"));
		obj.put("content_date",rs2.getString("content_date"));
		
		board_list.add(obj);
	}
	root.put("board_list",board_list);
	
	db.close();
%>
<%=root.toJSONString()%>