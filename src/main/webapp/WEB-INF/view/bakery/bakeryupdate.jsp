<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bakery Update</title>
<style type="text/css">
table{
		border-collapse : collapse;
		border-spacing : 0;
		margin :auto;
		width: 50%;
		display: table;
		line-height: 50px;
		text-align: center;
	}
	.button{
		text-align: center;
		padding-top: 30px;
	}
</style>
<script type="text/javascript">
   function inputcheck(f) {
	   console.log(f.opentime)
	   return false
   }
   
</script>
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
  <div class="w3-content containerbox" style="max-width:700px">
  	<h5 class="w3-center w3-padding-48">
    	<span class="w3-tag w3-wide">빵집 정보 수정</span>  
    </h5>
    
  
	  <div class="w3-container w3-padding-48 w3-card">
	  <form:form modelAttribute="bakery" method="post" action="bakeryupdate" onsubmit="inputcheck(this)">
	  	<spring:hasBindErrors name="user">
		    <font color="red">
		      <c:forEach items="${errors.globalErrors}" var="error">
		        <spring:message code="${error.code}" />
		      </c:forEach>
		    </font>
  		</spring:hasBindErrors>
	  	<input type="hidden" name="userid" value=${param.userid }>
	  	<input type="hidden" name="bakeryid" value=${param.bakeryid }>
	  	<table>
	  		<tr>
	  			<td>빵집이름</td>
	  			<td>${bakery.bname }</td>
	  		</tr>
	  		<tr>
	  			<td>위치</td>
	  			<td>${bakery.location }</td>
	  		</tr>
	  		<tr>
	  			<td>오픈시간</td>
	  			<td><form:input path="opentime" /></td>
	  		</tr>
	  		<tr>
	  			<td>마감시간</td>
	  			<td><form:input path="closetime" /></td>
	  		</tr>
	  		<tr>
	  			<td>휴무일</td>
	  			<td><form:input path="dayoff" /></td>
	  		</tr>
	  		<tr>
	  			<td>전화번호</td>
	  			<td>${bakery.bakerytel }</td>
	  		</tr>
	  		<tr>
	  			<td>좋아요 수</td>
	  			<td>${bakery.likeno }</td>
	  		</tr>
	  		<tr>
	  			<td>조회수</td>
	  			<td>${bakery.viewno }</td>
	  		</tr>
	  	</table>
	  	<div class="button">
	  		<input class="w3-button w3-black" type="submit" value="정보 수정">
	  		<a class="w3-button w3-black" href="../user/mypage?id=${user.userid }">닫기</a>
	  	</div>
	  	</form:form>
	  	
	  </div>
  </div>
</div>
</body>
</html>