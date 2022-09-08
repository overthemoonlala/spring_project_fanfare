<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빵집리스트</title>
<style type="text/css">
table{width:100%}
table, th, td{ border: 1px solid w3-light-grey; border-collapse:collapse;}
</style>
</head>
<body>
<div class="w3-container" id="menu">
 <div class="w3-content" style="max-width: 700%">
 <h5 class="w3-center w3-padding-48"><span class="w3-tag w3-wide">Bakery List</span></h5>
  
    <div class="w3-row w3-center w3-card w3-padding">
      <a href="javascript:void(0)" onclick="openMenu(event, 'Like');" id="myLink">
        <div class="w3-col s6 tablink w3-dark-grey">인기순</div>
      </a>
      <a href="javascript:void(0)" onclick="openMenu(event, 'Read');">
        <div class="w3-col s6 tablink">조회순</div>
      </a>
    </div>

    <div id="Like" class="w3-container menu w3-padding-48 w3-card" style="display: block;">
      <table border="1">
      <tr><th>상호명</th><th>위치</th><th>좋아요수</th></tr>
      <c:if test="${listcount != null}">
      <c:forEach var="bakery" items="${bakerylist}">
        <tr><td style="text-align: left">
        <a href="bakeryinfo?bakeryid=${bakery.bakeryid}">${bakery.bname}</a></td>
        <td>${bakery.location}</td>
        <td>❤ ${bakery.likeno}</td></tr>
       </c:forEach>
   <!-- 페이징부분 -->     
        <tr><td colspan="5">
   <div class="w3-center w3-padding-32">
    <div class="w3-bar">
     <c:if test="${pageNum > 1}">
      <a href="bakerylist?pageNum=${pageNum - 1}&pageid=${pageid}">[이전]</a></c:if>
      <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage}" end="${endpage}">
       <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
       <c:if test="${a != pageNum}">
        <a class="w3-button w3-hover-black"
           href="bakerylist?pageNum=${a}&pageid=${pageid}">${a}</a></c:if>
     </c:forEach>  
       <c:if test="${pageNum < maxpage}">
         <a href="bakerylist?pageNum=${pageNum + 1}&pageid=${pageid}">[다음]</a></c:if>
       <c:if test="${pageNum >= maxpage}">[다음]</c:if>
     </div></div></td></tr> 
  </c:if>
  </table>
    </div>
    
    <div id="Read" class="w3-container menu w3-padding-48 w3-card" style="display: none;">
      <table border="1">
      <tr><th>상호명</th><th>위치</th><th>조회수</th></tr>
        <c:if test="${listcount != null}">
        <c:forEach var="bakery" items="${bakerylist}">
        <tr><td style="text-align: left">
        <a href="bakeryinfo?bakeryid=${bakery.bakeryid}">${bakery.bname}</a></td>
        <td>${bakery.location}</td>
        <td>👀 ${bakery.viewno}</td></tr>
      </c:forEach>
      <tr><td colspan="5">
   <div class="w3-center w3-padding-32">
    <div class="w3-bar">
     <c:if test="${pageNum > 1}">
      <a href="bakerylist?pageNum=${pageNum - 1}&pageid=${pageid}">[이전]</a></c:if>
      <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage}" end="${endpage}">
       <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
       <c:if test="${a != pageNum}">
        <a class="w3-button w3-hover-black"
           href="bakerylist?pageNum=${a}&pageid=${pageid}">${a}</a></c:if>
     </c:forEach>  
       <c:if test="${pageNum < maxpage}">
         <a href="bakerylist?pageNum=${pageNum + 1}&pageid=${pageid}">[다음]</a></c:if>
       <c:if test="${pageNum >= maxpage}">[다음]</c:if>
     </div></div></td></tr> 
  </c:if>
      </table>
    </div>
  </div>  
</div>      
<script>
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