<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
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
<script type="text/javascript">
   function inchk(f) {
	   if(f.chgpass.value != f.chgpass2.value) {
		   alert("변경 비밀번호 와 변경 비밀번호 재입력이 다릅니다.");
		   f.chgpass2.value="";
		   f.chgpass2.focus();
		   return false; 
	   }
	   //chgpass 값이 3자리 미만경우 오류 발생하기
	   let passlen = f.chgpass.value.length
	   if(passlen < 3 || passlen > 10) {
		   alert("변경 비밀번호는 3자 이상 10자 미만 이어야 합니다.");
		   f.chgpass.focus();
		   return false; 
	   }
	   return true;
   }</script>
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
  <div class="w3-content containerbox" style="max-width:700px">
  	<h5 class="w3-center w3-padding-48">
    	<span class="w3-tag w3-wide">비밀번호 수정</span>  
    </h5>
    <div class="w3-container w3-padding-48 w3-card">
	  	<form action="password" method="post" name="f" onsubmit="return inchk(this)">
	  		<table>
				<tr><th>현재 비밀번호</th><td><input type="password" name="password"></td></tr>
	  			<tr><th>변경 비밀번호</th><td><input type="password" name="chgpass"></td></tr>
	  			<tr><th>변경 비밀번호 재입력</th><td><input type="password" name="chgpass2"></td></tr>
	  		</table>
	  		<div class="button">
	  			<input class="w3-button w3-black" type="submit" value="비밀번호 변경">
	  			<a class="w3-button w3-black" href="mypage?id=${user.userid }">닫기</a>
	  		</div>
	  	</form>
	  	
  	</div>
  </div>
  
 
</div>
</body>
</html>