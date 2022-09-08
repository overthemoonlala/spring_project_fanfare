<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>메인페이지</title>
<!-- http://localhost:8088/fanfare/user/fanfare1 -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Inconsolata">
<style>
body, html {
  height: 100%;
  font-family: "Inconsolata", sans-serif;
}

.bgimg {
  background-position: center;
  background-size: cover;
  
}

.menu {
  display: none;
}

table{
		margin :auto;
		display: table;
		line-height: 30px;
		text-align: center;
	}
</style>


<!-- 카카오지도 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5bf0039c76a95193cbf8dca453ab0b6b"></script>
</head>
<body>

<!-- Header with image -->
<header class="bgimg w3-display-container" id="home">
<img src="<%=request.getContextPath()%>/img/bread.png" width=100%" height="500px;"/> 
  <div class="w3-display-middle w3-center">
    <span class="w3-text-brown" style="font-size:120px">fanfare</span>
  </div>
</header>
<br>



<!-- |||부분 크기 설정 -->
<div class="w3-container" id="menu">
  <div class="w3-content" style="max-width:700px">
  
  
  <!-- 클릭되는 부분 지역순, top5, 리뷰많은순 -->
    <div class="w3-row w3-center w3-card w3-padding" >
      <a href="javascript:void(0)" onclick="openMenu(event, 'map');"  id="myLink">
      	<div class="w3-col s6 tablink" style="width:33.3%" >지역순</div>
      </a>
      <a href="javascript:void(0)" onclick="openMenu(event, 'top');" >
        <div class="w3-col s6 tablink" style="width:33.3%">TOP5</div>
      </a>
      <a href="javascript:void(0)" onclick="openMenu(event, 'review');">
        <div class="w3-col s6 tablink" style="width:33.3%" >리뷰 많은 순</div>
      </a>
    </div>
    

	<!--  내부 -->
    <div id="map" class="w3-Fcontainer menu w3-padding-48 w3-card" style="height:400px;" >
    </div>
    
    
    
    <div id="top" class="w3-container menu w3-padding-48 w3-card"  style="height:700px;">
    	<table border="1" width="650px" >
		    <tr>
		        <th>순위</th>
		        <th>이름</th>
		        <th>위치</th>
		        <th>구경가기</th>
		    </tr>
		    <c:forEach items="${bakerylist}" var="bakery">
			    <tr>
				  	<td>${bakery.no}</td>
				 	<td>${bakery.name}</td>
				 	<td>${bakery.location}</td>
				 	<td><a href="bakery?id=${bakery.id}">구경하기</a></td>
			    <tr>
  			</c:forEach>
		</table>
    </div> 
    
    
    
    
    <div id="review" class="w3-container menu w3-padding-48 w3-card"  style="height:700px;">
    	<table border="1" width="650px" >
		    <tr>
		        <th>순위</th>
		        <th>이름</th>
		        <th>위치</th>
		        <th>구경가기</th>
		    </tr>
		    <c:forEach items="${bakerylist}" var="bakery">
			    <tr>
				  	<td>${bakery.no}</td>
				 	<td><a href="bakery?id=${bakery.id}">${bakery.name}</a></td>
				 	<td>${bakery.location}</td>
				 	<td><a href="bakery?id=${bakery.id}">구경하기</a></td>
			    <tr>
		    </c:forEach>
		</table>
    </div> 
    
    
<!-- |||부분 크기 설정 태그 닫기 -->    
  </div>
</div>

<script>
//카카오 지도


var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(37.56544088003082, 126.97708499322151), //지도의 중심좌표.(서울시청)
	level: 9 //지도의 레벨(확대, 축소 정도)
};
var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴



// Tabbed Menu
function openMenu(evt, menuName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("menu");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  
  for (i = 0; i < x.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" w3-dark-grey", "");
  }
  document.getElementById(menuName).style.display = "block";
  evt.currentTarget.firstElementChild.className += " w3-dark-grey";
}
document.getElementById("myLink").click();
</script>
</body>
</html>
