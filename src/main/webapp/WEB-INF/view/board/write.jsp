<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- /WEB-INF/view/board/write.jsp --%>    
<%--http://localhost:8088/fanfare/board/write --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

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
<form:form modelAttribute="board" action="write" enctype="multipart/form-data" name="f">
  <table><caption>${boardName} 게시글 작성</caption>
  <tr>
  	<td>글쓴이</td><td><form:input path="writer" />
  	<font color="red"><form:errors path="writer" /></font></td></tr>
  <tr>
  	<td>비밀번호</td><td><form:password path="pass" />
  	<font color="red"><form:errors path="pass" /></font></td></tr>
  <tr>
  	<td>제목</td><td><form:input path="subject" />
  	<font color="red"><form:errors path="subject" /></font></td></tr>
  <tr>
  	<td>내용</td><td><form:textarea  path="content" rows="15" cols="80"/>
   <script type="text/javascript">
     CKEDITOR.replace("content",{filebrowserImageUploadUrl:"imgupload"})
  </script>
  <font color="red"><form:errors path="content" /></font></td></tr>
  <tr>
  	<td>첨부파일</td><td><input type="file" name="file1"></td></tr>
  <tr>
  	<td colspan="2"><a href="javascript:document.f.submit()">[게시글등록]</a>
  	<a href="list">[게시글목록]</a></td></tr>
</table>
</form:form>
</body>
</html>