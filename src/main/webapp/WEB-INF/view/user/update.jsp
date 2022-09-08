<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update</title>
<style type="text/css">
table{
		border-collapse : collapse;
		border-spacing : 0;
		margin :auto;
		width : 100%
		display: table;
		line-height: 50px;
		text-align: center;
	}
	td {
		width:50%;
	}
	.button{
		text-align: center;
		padding-top: 30px;
	}
	font{
		display:block;
		text-align:center;
	}
</style>
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
  <div class="w3-content containerbox" style="max-width:700px">
  	<h5 class="w3-center w3-padding-48">
    	<span class="w3-tag w3-wide">회원 정보 수정</span>  
    </h5>
    
  
	  <div class="w3-container w3-padding-48 w3-card">
	  <form:form modelAttribute="user" method="post" action="update">
	  	<spring:hasBindErrors name="user">
		    <font color="red">
		      <c:forEach items="${errors.globalErrors}" var="error">
		        <spring:message code="${error.code}" />
		      </c:forEach>
		    </font>
  		</spring:hasBindErrors>
  		<input type="hidden" name="passCheck" value="12345678"/>
	  	<table>
	  		<tr>
	  			<td>아이디</td>
	  			<td><form:input path="userid" readonly="true"/>
	  			<font color="red"><form:errors path="userid" /></font></td>
	  		</tr>
	  		<tr>
	  			<td>비밀번호</td>
	  			<td><form:password path="pass"  />
	  			<font color="red"><form:errors path="pass" /></font></td>
	  		</tr>
	  		<tr>
	  			<td>이름</td>
	  			<td><form:input path="name" />
	  			<font color="red"><form:errors path="name" /></font></td>
	  		</tr>
	  		<tr>
	  			<td>이메일</td>
	  			<td><form:input path="email"/>
	  			<font color="red"><form:errors path="email" /></font></td>
	  		</tr>
	  		<tr>
	  			<td>전화번호</td>
	  			<td><form:input path="tel"/>
	  			<font color="red"><form:errors path="tel" /></font></td>
	  		</tr>
	  		<tr class="button">
	  			
	  		</tr>
	  	</table>
	  	<div class="button">
	  		<input class="w3-button w3-black" type="submit" value="정보 수정">
	  		<a class="w3-button w3-black" href="mypage?id=${user.userid }">닫기</a>
	  	</div>
	  	</form:form>
	  	
	  </div>
  </div>
</div>
</body>
</html>