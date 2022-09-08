<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bakery Update</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript">
	function sendclose() {
		self.close();
	}
</script>
<style type="text/css">
table {
	border-collapse: collapse;
	border-spacing: 0;
	margin: auto;
	width: 70%;
	display: table;
	line-height: 50px;
	text-align: center;
}

.button {
	text-align: center;
	padding-top: 30px;
}
.bakeryimg, .menuimg{
	width:100px;
}
</style>
</head>
<body>
	<div class="w3-container" id="menu" style="padding-bottom: 32px;">
		<div class="w3-content containerbox" style="max-width: 700px">
			<div class="w3-container w3-padding-48 w3-card">
				<form method="post" action="bakerydetail" name="bakerydetail">
					<input type="hidden" name="bakeryid" value=${param.bakeryid }>
					<table>
						<tr>
							<td>빵집아이디 : ${bakery.bakeryid }</td>
						</tr>
						<tr>
							<td>사용자아이디 : ${bakery.userid }</td>
						</tr>
						<tr>
							<td>빵집이름 : ${bakery.bname }</td>
						</tr>
						<tr>
							<td><img class="bakeryimg" src="../bakery/file/${bakery.fileurl }"></td>
						</tr>

						<tr>
							<td>${bakery.bakeryinfo }</td>
						</tr>
						<tr>
							<td>위치 : ${bakery.location }</td>
						</tr>
						<tr>
							<td>오픈시간 : ${bakery.opentime }</td>
						</tr>
						<tr>
							<td>마감시간 : ${bakery.closetime }</td>
						</tr>
						<tr>
							<td>휴무일 : ${bakery.dayoff }</td>
						</tr>
						<tr>
							<td>전화번호 : ${bakery.bakerytel }</td>
						</tr>
						
					</table>
					<hr>
					<h4 style="text-align: center;">[대표메뉴]</h4>
					<table>
						<tr>
							<th>메뉴이름</th><th>메뉴사진</th><th>메뉴설명</th>
						</tr>
						<c:forEach items="${bakerymenulist }" var="menu" varStatus="status">
							<tr>
								<td><c:out value="${menu.menuname }" /></td>  
								<td><img class="menuimg" src="../bakery/menu/file/${menu.menufileurl }"></td> 
								<td><c:out value="${menu.menuinfo }" /></td>
							</tr>
						</c:forEach>
					</table>
					<div class="button">
						<a class="w3-button w3-black" href="javascript:bakerydetail.submit()">승인</a>
					</div>
				</form>


			</div>
		</div>
	</div>
</body>
</html>