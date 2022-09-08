<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/board/reply.jsp --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 답글 쓰기</title>
<style>

table{
		border-collapse : collapse;
		border-spacing : 0;
		margin :auto;
		width: 70%;
		display: table;
		line-height: 50px;
		text-align: center;
	}
	
th,td {
	border : 3px solid #bcbcbc;
	text-align: center;
	padding : 8px;
}
input[type=text],input[type=password],textarea {	width : 100%;  }
              
</style>
</head>
<body>
<form:form modelAttribute="board" action="reply"   method="post" name="f">
  <form:hidden  path="num" /> <%-- 원글의 게시물 번호 --%>
  <form:hidden  path="grp" /> <%-- 원글의 그룹 번호 --%>
  <form:hidden  path="grplevel" /> <%-- 원글의 답변글의 단계 번호 --%>
  <form:hidden  path="grpstep" />  <%-- 원글의 그룹의 출력 순서  --%>
  
  
  <table><caption> 게시판 댓글 등록</caption>
  <tr>
  	<td>글쓴이</td><td><input type="text" name="writer">
    <font color="red"><form:errors path="writer" /></font></td></tr>
  <tr><td>비밀번호</td><td><form:password path="pass" />
    <font color="red"><form:errors path="pass" /></font></td></tr>
  <tr><td>제목</td><td><form:input path="subject" value="RE:${board.subject}"/> 
  	<font color="red"><form:errors path="subject" /></font></td></tr>
  <tr><td>내용</td><td><textarea name="content" rows="15" cols="80"></textarea>
 	 <script type="text/javascript">
   	  CKEDITOR.replace("content",{ filebrowserImageUploadUrl : "imgupload"});
 	 </script>
  	<font color="red"><form:errors path="content" /></font></td></tr>
  <tr><td colspan="2">
 	 <a href="javascript:document.f.submit()">[답변글등록]</a></td></tr>    
  </table>
  
  
  </form:form>
  </body>
  </html>