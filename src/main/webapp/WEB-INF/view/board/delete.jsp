<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%-- /webapp/WEB-INF/view/board/delete.jsp --%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 삭제 화면</title>
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
<form action="delete"  method="post"  name="f">
<spring:hasBindErrors name="board">
	<font color="red"><c:forEach items="${errors.globalErrors}"
	var="error"><spring:message code="${error.code }" /></c:forEach>
	</font></spring:hasBindErrors>
<input type="hidden" name="num" value="${param.num}">
<table><caption>게시글 삭제 화면</caption>
	<tr>
		<td>게시글비밀번호</td>
		<td><input type="password" name="pass" /></td>
	</tr>
	<tr>
		<td colspan="2">
		<a href="javascript:document.f.submit()">[게시글삭제]</a></td>
	</tr>
</table>
</form>
</body>
</html>