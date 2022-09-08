<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
  if('${param.msg}'){
	  alert('${param.msg}')
  }
</script>
<style type="text/css">
table{width:100%}
table, th, td{ border: 1px solid w3-light-grey; border-collapse:collapse;}
</style>
</head>
<body>

<table>
  <c:if test="${listcount > 0}">
    <tr><th>no</th><th>작성자</th><th>제목</th><th>작성시간</th></tr>
    <!-- review 부분 -->
  <c:forEach var="bakery" items="${bakeryreview}">
    <tr><td>${bakery.no}</td>
        <td>${bakery.writer}</td>
        <c:set var="bakeryno" value="${bakeryno - 1}" />
        <td style="text-align: left">
        <c:if test="${! empty bakery.fileurl}"><a href="file/${bakery.fileurl}">@</a></c:if>
        <c:if test="${empty bakery.fileurl}">&nbsp;&nbsp;&nbsp;</c:if>
  <c:forEach begin="1" end="${bakery.grplevel}">&nbsp;&nbsp;</c:forEach>
        <c:if test="${bakery.grplevel > 0}">└</c:if>
       <a href="bakeryinfo?bakeryid=${bakery.bakeryid}">${bakery.subject}</a></td>
        <td><fmt:formatDate value="${bakery.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
  </c:forEach>
  
  <!-- 페이징 부분 -->
  <tr><td colspan="5">
   <div class="w3-center w3-padding-64">
    <div class="w3-bar">
     <c:if test="${pageNum > 1}">
      <a href="list?pageNum=${pageNum - 1}&bakeryid=${bakeryid}">[이전]</a></c:if>
      <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage}" end="${endpage}">
       <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
       <c:if test="${a != pageNum}">
        <a class="w3-button w3-hover-black"
           href="list?pageNum=${a}&bakeryid=${bakeryid}">${a}</a></c:if>
     </c:forEach>  
       <c:if test="${pageNum < maxpage}">
         <a href="list?pageNum=${pageNum + 1}&bakeryid=${bakeryid}">[다음]</a></c:if>
       <c:if test="${pageNum >= maxpage}">[다음]</c:if>
     </div></div></td></tr> 
  </c:if>
  <c:if test="${listcount == 0}">
       <tr><td colspan="5">등록된 게시물이 없습니다.</td></tr>
  </c:if>
  <!-- 관리자로 로그인 한 경우만 글쓰기 부분 출력하기 -->
  <c:if test="${!empty param.blist && !empty param.bakeryinfo}">
    <tr><td colspan="5" align="right"><a href="write">[글쓰기]</a></td></tr>
  </c:if>
  <c:if test="${empty param.blist || empty param.bakeryinfo}">
    <c:if test="${loginUser.userid == 'admin'}" >
    <tr><td colspan="5" align="right"><a href="write">[글쓰기]</a></td></tr>
    </c:if>
    </c:if>
 </table>
</body>
</html>