<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빵집 승인</title>
<script type="text/javascript">
function win_open(page) {
	   var op = "width=600, height=700, left=50,top=150";
	   open(page,"",op);
}
</script>
<style type="text/css">
	table{
		border-collapse : collapse;
		border-spacing : 0;
		margin :auto;
		width: 100%;
		display: table;
		line-height: 50px;
		text-align: center;
	}
	.button{
	text-align: center;
	padding-top: 30px;
}
</style>
</head>
<body>
	<div class="w3-container" id="menu" style="padding-bottom: 32px;">
		<div class="w3-content containerbox" style="max-width: 700px">
			<h5 class="w3-center w3-padding-48">
				<span class="w3-tag w3-wide">승인 리스트</span>
			</h5>
			<div class="tab w3-container w3-padding-48 w3-card">

				<table>
					<tr>
						<td>번호</td>
						<td>사용자아이디</td>
						<td>빵집아이디</td>
						<td>이름</td>
						<td></td>
					</tr>

					<c:forEach items="${bakerylist }" var="bakery" varStatus="status">
						<tr>
							<td>${status.count }</td>
							<td><c:out value="${bakery.userid }" /></td>
							<td><c:out value="${bakery.bakeryid }" /></td>
							<td><c:out value="${bakery.bname }" /></td>
							<td><input class="w3-button w3-black" type="button" value="상세정보" style="padding: 0 16px;" onclick="win_open('../bakery/bakerydetail?bakeryid=${bakery.bakeryid }')"></td>

						</tr>
					</c:forEach>


				</table>
				<div class="button">
					<a class="w3-button w3-black" href="../user/mypage?id=admin">닫기</a>
	  			</div>
			</div>
		</div>
	</div>
</body>
</html>