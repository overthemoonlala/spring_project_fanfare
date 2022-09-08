<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete</title>
<style>
table, form{
		border-collapse : collapse;
		border-spacing : 0;
		margin :auto;
		display: table;
		line-height: 50px;
		text-align: center;
	}
	th{
		padding : 0px 15px;
	}
	.button{
		text-align: center;
		padding-top: 30px;
	}
</style>
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
  <div class="w3-content containerbox" style="max-width:700px">
  	<h5 class="w3-center w3-padding-48">
    	<span class="w3-tag w3-wide">예약자 정보 조회</span>  
    </h5>
    <div class="w3-container w3-padding-48 w3-card">
	  	<table>
	  		<tr>
	  			<th>번호</th><th>예약자ID</th><th>예약자 이름</th><th>예약일자</th>
	  		</tr>
	  		<c:forEach items="${reservationlist }" var="reservation" varStatus="status">
				<tr>
					<td>${status.count }</td>
					<td><c:out value="${reservation.userid }" /></td> 
					<td><c:out value="${reservation.name }" /></td>
					<td><fmt:formatDate value="${reservation.predate }" pattern="yyyy-MM-dd"/></td>
				
				</tr>
			</c:forEach>
	  	</table>
		<div class="button">
			<a class="w3-button w3-black" href="../user/mypage?id=${user.userid }">닫기</a>
	  	</div>  </div>
  </div>
  
</div>
</body>
</html>