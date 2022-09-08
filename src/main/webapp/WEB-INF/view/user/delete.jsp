<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    

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
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
  <div class="w3-content containerbox" style="max-width:700px">
  	<h5 class="w3-center w3-padding-48">
    	<span class="w3-tag w3-wide">회원 탈퇴</span>  
    </h5>
    <div class="w3-container w3-padding-48 w3-card">
	  	<table>
	  		<tr><td>아이디</td><td>${user.userid }</td></tr>
	  		<tr><td>이름</td><td>${user.name }</td></tr>
	  		<tr><td>이메일</td><td>${user.email }</td></tr>
	  	</table>
	  	
	  	<form method="post" action="delete" name="deleteform">
		    <input type="hidden" name="userid" value="${param.id}">
		    비밀번호 <input type="password" name="password">
		    
		    <div class="button">
				<a class="w3-button w3-black" href="javascript:deleteform.submit()">회원탈퇴</a>
				<a class="w3-button w3-black" href="mypage?id=${user.userid }">닫기</a>
			</div>
	 	 </form>
	 	 
  </div>
  </div>
  
</div>
</body>
</html>