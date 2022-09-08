<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />               
<!DOCTYPE html>
<html>
<head>
<title>
<sitemesh:write property='title'/> 
</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inconsolata">

<!-- <link rel="stylesheet" href="${path}/css/main.css">  -->
<style>
body, html {
  height: 100%;
  font-family: "Inconsolata", sans-serif;
}


.menu1 {
  display: none;
}
#content1{
	margin-top : 54.5px;
}
</style>


<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%-- 글작성시 다양한 형태 사용 가능 --%>	

<script type="text/javascript" 
   src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
	
<sitemesh:write property='head'/>
</head>

<body>

<!-- Links (sit on top) -->
<div class="w3-top">
  <div class="w3-row w3-padding w3-black">
    <c:choose>
    	<c:when test="${sessionScope.loginUser.userid == null}">
	    	<div class="w3-col" style="width: 25%">
		      <a href="${path}/user/fanfare1" class="w3-button w3-block w3-black">HOME</a>
		    </div>
		    <div class="w3-col" style="width: 25%">
		      <a href="${path}/bakery/bakerylist" class="w3-button w3-block w3-black">STORE</a>
		    </div>
		    <div class="w3-col" style="width: 25%">
		      <a href="${path}/board/list" class="w3-button w3-block w3-black">BOARD</a>
		    </div>
    		<div class="w3-col" style="width: 25%">
      			<a href="${path}/user/login" class="w3-button w3-block w3-black">LOGIN</a>  
    		</div>
    	</c:when>
    	<c:otherwise>
	    	<div class="w3-col" style="width: 20%">
		      <a href="${path}/user/fanfare1" class="w3-button w3-block w3-black">HOME</a>
		    </div>
		    <div class="w3-col" style="width: 20%">
		      <a href="${path}/bakery/bakerylist" class="w3-button w3-block w3-black">STORE</a>
		    </div>
		    <div class="w3-col" style="width: 20%">
		      <a href="${path}/board/list" class="w3-button w3-block w3-black">BOARD</a>
		    </div>
    		<div class="w3-col" style="width: 20%">
      			<a href="${path}/user/mypage?id=${loginUser.userid}" class="w3-button w3-block w3-black">MYPAGE</a>
    		</div>  
    		<div class="w3-col" style="width: 20%">
		      <a href="${path}/user/logout" class="w3-button w3-block w3-black">LOGOUT</a>
		    </div>
    	</c:otherwise>   
    </c:choose>

  </div>
</div>

<div class="w3-sand w3-grayscale w3-large">
<div id="content1">
	<sitemesh:write property='body'/>
</div>

<!-- Footer -->
<footer class="w3-center w3-light-grey w3-padding-48 w3-large">
  <p>fanfare</a></p>
</footer>



</body>
</html>