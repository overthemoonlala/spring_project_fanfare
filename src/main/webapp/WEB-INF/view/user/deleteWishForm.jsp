<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
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
</head>
<body>
<div class="w3-container" id="menu" style="padding-bottom:32px;">
  <div class="w3-content containerbox" style="max-width:700px">
	  <div class="w3-container w3-padding-48 w3-card">
	  	<form method="post" action="deleteWishForm" name="deleteWish">
		
			<input type="hidden" name="userid" value=${param.userid }>
	  	  	<input type="hidden" name="bakeryid" value=${param.bakeryid }>
		    ${wish.bname }를 위시리스트에서 삭제하시겠습니까?
		    <div class="button">
				<a class="w3-button w3-black" href="javascript:deleteWish.submit()">삭제</a>
			</div>
	 	 </form>
		  
	  	
	  </div>
  </div>
</div>
</body>
</html>