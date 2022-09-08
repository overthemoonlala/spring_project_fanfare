<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Reservation</title>
<script type="text/javascript">
function win_open(page) {
	   var op = "width=500, height=200, left=50,top=150";
	   open(page,"",op);
}
</script>
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
	padding: 0 20px;
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
    	<span class="w3-tag w3-wide">나의 예약 조회</span>  
    </h5>
    <div class="w3-container w3-padding-48 w3-card">
	  	<table>
	  		<tr>
	  			<th>번호</th><th>빵집이름</th><th>예약시간</th><th>예약대기번호</th><th></th></tr>
	  		<c:forEach items="${reservationlist }" var="reservation" varStatus="status">
				<tr>
					<td>${status.count }</td>
					<td><c:out value="${reservation.bname }" /></td> 
					<td><fmt:formatDate value="${reservation.predate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td><c:out value="${reservation.prenum }" /></td>
					<td><input class="w3-button w3-black" type="button" value="예약취소" style="padding: 0 16px;" onclick="win_open('deleteForm?userid=${reservation.userid}&&bakeryid=${reservation.bakeryid }')"></td>
				</tr>
			</c:forEach>
	  	</table>
	  	
	 	 <div class="button">
			<a class="w3-button w3-black" href="mypage?id=${user.userid }">닫기</a>
		</div>
  </div>
  </div>
  
</div>
</body>
</html>