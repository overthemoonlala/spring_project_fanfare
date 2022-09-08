<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/update.jsp --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 수정 화면</title>
<style>
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
#footer {position: fixed; bottom: 100px;}
.select {
   background-color: gray;   
}
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
<script type="text/javascript">
 function file_delete() {
   document.updateform.file2.value=""; <%-- 수정 전 첨부파일 이름 --%>
   <%-- 첨부파일 조회 영역을 안보이도록--%>
   document.getElementById("file_desc").style.display="none"; 
 }
</script>
<style type="text/css"> .errortext {color : red; }</style>
</head>
<body>
<form:form modelAttribute="board" action="update" enctype="multipart/form-data" name="updateform">
<input type="hidden" name="file2" value="${board.fileurl}" >
<form:hidden path="num" />  
<form:hidden path="writer" />
<table>
<tr>
	<td colspan="2">게시판 수정</td>
</tr>
<tr>
	<td>제목</td>
	<td><form:input path="subject"/>
   <form:errors path="subject" class="errortext"/>
  </td></tr> 
<tr>
	<td>내용</td>
	<td><form:textarea path="content" cols="67" rows="15"/>
  <script type="text/javascript">
     CKEDITOR.replace("content",{ filebrowserImageUploadUrl : "imgupload"});
  </script>
      <form:errors path="content" class="errortext"/></td></tr>
<tr>
	<td>첨부파일</td><td>&nbsp;
   <c:if test="${!empty board.fileurl}"> <%-- 수정전에 첨부파일 존재  --%>
    	 <div id="file_desc"><a href="file/${board.fileurl}">${board.fileurl}</a>&nbsp;
        	 <a href="javascript:file_delete()">[첨부파일삭제]</a>
    	 </div>
    </c:if>
     <input type="file" name="file1" id="file1">
   </td>
</tr>
<tr>
	<td>비밀번호</td>
   <td><form:password path="pass" /><form:errors path="pass" class="errortext"/></td>
</tr>
<tr>
	<td colspan="2" align="center">
    <a href="javascript:document.updateform.submit()">[수정]</a>&nbsp;
    <a href="list?boardid=${boardid}">[목록]</a></td>
</tr>
</table>
</form:form>
</body>
</html>