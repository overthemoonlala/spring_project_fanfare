<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage</title>
<script type="text/javascript">
function disp_div(id, tab){
	$(".tab").hide();
	$(".tablink").removeClass("w3-dark-grey");
	$("#" + id).show();
	$("." + tab).addClass("w3-dark-grey");
}
function win_open(page) {
	   var op = "width=500, height=200, left=50,top=150";
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
	#Info td{
		width: 50%;
	}
	.menu{
		display:none;
	}
	tab{
		display:none;
	}
	.button{
		text-align: center;
		padding-top: 30px;
	}
	h5{
		position : relative;
	}
	h5>a {
		position : absolute;
		right : 0;
	}
	#BInfo>p{
		text-align: center
	}
</style>
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
	<div class="w3-content containerbox" style="max-width:700px">
	  	<h5 class="w3-center w3-padding-48">
	    	<span class="w3-tag w3-wide">${user.name }님의 마이페이지</span>  
	    	<c:if test="${user.type == 0 && loginUser.userid != 'admin'}">
	    		<a class="w3-button w3-black" href="myreservation?id=${user.userid }">예약조회</a>
	    	</c:if>
	    	<c:if test="${loginUser.userid == 'admin'}">
	    		<a class="w3-button w3-black" href="../admin/list">빵집승인</a>
	    	</c:if>
	    </h5>
	  	
	  	<!-- select tab -->
	    <div class="w3-row w3-center w3-card w3-padding">
	    	<!-- tab1 -->
		    <a href="javascript:void(0)" onclick="disp_div('Info', 'tab1');">
		        <div class="w3-col s6 tablink tab1 w3-dark-grey">My Info</div>
		    </a>
		    
		    <!-- tab2 -->
		    <c:if test="${loginUser.userid != 'admin'}">
		      	<c:if test="${user.type == 0 }">
					<a href="javascript:void(0)" onclick="disp_div('Wish', 'tab2');">
						<div class="w3-col s6 tablink tab2">Wish List</div>
					</a>
				</c:if>
				<c:if test="${user.type == 1 }">
					<a href="javascript:void(0)" onclick="disp_div('BInfo', 'tab2');">
						<div class="w3-col s6 tablink tab2">Bakery Info</div>
					</a>
				</c:if>
			</c:if>
			<c:if test="${loginUser.userid == 'admin'}">
				<a href="javascript:void(0)" onclick="disp_div('UserList', 'tab2');">
					<div class="w3-col s6 tablink tab2">User List</div>
				</a>
			</c:if>
	    </div>
	    
	    <!-- tab1 -->
	    <div id="Info" class="tab w3-container w3-padding-48 w3-card">
	    	<table>
				<tr>
					<td>아이디</td><td>${user.userid }</td>
				</tr>
				<tr>
					<td>이름</td><td>${user.name }</td>
				</tr>
				<tr>
					<td>이메일</td><td>${user.email }</td>
				</tr>
				<tr>
					<td>전화번호</td><td>${user.tel }</td>
				</tr>
	    	</table>
	    	
	    	<div class="button">
	    		<a class="w3-button w3-black" href="update?id=${user.userid}">회원정보수정</a>
	    		<a class="w3-button w3-black" href="password?id=${user.userid}">비밀번호수정</a>
	    		<c:if test="${loginUser.userid != 'admin'}">
		    		<a class="w3-button w3-black" href="delete?id=${user.userid}">회원탈퇴</a>
		    	</c:if>
	    	</div>
	    </div>
	    
	    <!-- tab2 -->
	    <div id="Wish" class="tab w3-container menu w3-padding-48 w3-card" >
		      <table>
		      	<tr>
		      		<th>번호</th><th>빵집이름</th><th>등록일자</th><th></th>
		      	</tr>
				<c:forEach items="${wishlist }" var="wish" varStatus="status">
					<tr>
						<td>${status.count }</td>
						<td><c:out value="${wish.bname }" /></td> 
						<td><fmt:formatDate value="${wish.wishdate }" pattern="yyyy-MM-dd"/></td>
						<td><input type="button" value="ⓧ" style="background-color:inherit; border:0; cursor: pointer; color: red" onclick="win_open('deleteWishForm?userid=${wish.userid}&&bakeryid=${wish.bakeryid }')"></td>
						
					</tr>
				</c:forEach>
		      </table>
		</div>  
		<c:if test="${bakery.bakeryid != null && bakery.adminchk == 1}">
		    <div id="BInfo" class="tab w3-container menu w3-padding-48 w3-card" >
			      <table>
			      	<tr>
						<td>빵집아이디</td><td>${bakery.bakeryid }</td>
					</tr>
					<tr>
						<td>빵집이름</td><td>${bakery.bname }</td>
					</tr>
					<tr>
						<td>위치</td><td>${bakery.location }</td>
					</tr>
					<tr>
						<td>오픈시간</td><td>${bakery.opentime }</td>
					</tr>
					<tr>
						<td>마감시간</td><td>${bakery.closetime }</td>
					</tr>
					<tr>
						<td>휴무일</td><td>${bakery.dayoff }</td>
					</tr>
					<tr>
						<td>전화번호</td><td>${bakery.bakerytel }</td>
					</tr>
					<tr>
						<td>좋아요수</td><td>${bakery.likeno }</td>
					</tr>
					<tr>
						<td>조회수</td><td>${bakery.viewno }</td>
					</tr>
					
		    	</table>
		    	<div class="button">
		    		<a class="w3-button w3-black" href="../bakery/bakeryupdate?userid=${user.userid}&&bakeryid=${bakery.bakeryid }">정보수정</a>
		    		<a class="w3-button w3-black" href="../bakery/reservation?id=${user.userid }">예약자 정보 조회</a>
		    	</div>
			</div>  
		</c:if>
		<c:if test="${bakery.bakeryid != null && bakery.adminchk == 0}">
			<div id="BInfo" class="tab w3-container menu w3-padding-48 w3-card" >
				<p>관리자의 승인을 기다리는 중입니다.</p>
			</div>
		</c:if>
		<c:if test="${bakery.bakeryid == null }">
			<div id="BInfo" class="tab w3-container menu w3-padding-48 w3-card" >
				<p>등록된 빵집 정보가 없습니다.</p>
			    <div class="button">
		    		<a class="w3-button w3-black" href="../bakery/bakeryEntry?id=${loginUser.userid }">정보 등록</a>
		    	</div>
			</div>
		</c:if>
	    <div id="UserList" class="tab w3-container menu w3-padding-48 w3-card" >
	    	<table>
	    		<tr>
	    			<td>번호</td><td>아이디</td><td>이름</td><td>전화번호</td><td>이메일</td><td>회원타입</td><td></td>
	    		</tr>
	    		
	    		<c:forEach items="${userlist }" var="user" varStatus="status">
	    			<tr>
		    			<td>${status.count }</td>
		    			<td><c:out value="${user.userid }" /></td>
		    			<td><c:out value="${user.name }" /></td>
		    			<td><c:out value="${user.tel }" /></td>
		    			<td><c:out value="${user.email }" /></td>
		    			<td><c:out value="${user.type == 0 ?'개인':'사장'}" /></td>
		    			<td><a href="delete?id=${user.userid}" style="text-decoration: none; color: red">ⓧ</a></td>
	    			</tr>
	    		</c:forEach>
	    		
	    		
	    	</table>
	    </div>
	    	
    	
	</div>
</div>
</body>
</html>