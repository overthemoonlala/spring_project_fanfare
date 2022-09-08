<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/board/list.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록 보기</title>
<!-- http://localhost:8088/fanfare/board/list -->
<style type="text/css">
html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
table{
		border-collapse : collapse;
		border-spacing : 0;
		margin :auto;
		width: 70%;
		display: table;
		line-height: 50px;
		text-align: center;
	}
	

th,td {
	border : 3px solid #bcbcbc;
	text-align: center;
	padding : 8px;
}
#container{
	width:400px;
	margin: 10px auto;
	padding:8px;
}

</style>
<script>
   if ('${param.msg}') { 
	   alert('${param.msg}')
   }
   
</script>
</head>
<body>
<br>
<%--▶ 공지사항/자유게시판/Q&A파트 --%>
<div id="container" >
    <a href="${path}/fanfare/board/list?boardid=1" class="w3-button w3-black"><i class="fa fa-users fa-fw"></i>&nbsp;공지사항</a>
    <a href="${path}/fanfare/board/list?boardid=2" class="w3-button w3-black"><i class="fa fa-users fa-fw"></i>&nbsp;자유게시판</a>
    <a href="${path}/fanfare/board/list?boardid=3" class="w3-button w3-black"><i class="fa fa-users fa-fw"></i>&nbsp;QNA</a>
</div>


<%--▶게시판 table --%>
<table>
  <tr>
  	<td colspan="4">${boardName} 게시판</td>
  	<td>글개수:${listcount}</td>
  </tr>
 <c:if test="${listcount > 0}">
  <tr>
  	<th>번호</th>
  	<th>제목</th>
  	<th>글쓴이</th>
  	<th>날짜</th>
  	<th>조회수</th>
  </tr>
 <c:forEach var="board" items="${boardlist}">
 <tr><td>${boardno}</td>
      <c:set var="boardno" value="${boardno - 1}" />
      <td style="text-align: left;">
      <c:if test="${! empty board.fileurl}"><a href="file/${board.fileurl}">@</a></c:if>
      <c:if test="${empty board.fileurl}">&nbsp;&nbsp;&nbsp;</c:if>
  <c:forEach begin="1" end="${board.grplevel}">&nbsp;&nbsp;</c:forEach>
      <c:if test="${board.grplevel > 0}">└</c:if> <%-- ㅂ한자 --%> 
    <a href="detail?num=${board.num}">${board.subject}</a></td>
      <td>${board.writer}</td>
      <td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
      <td>${board.readcnt}</td></tr>
 </c:forEach>
 
 
 
 <%-- ▶페이징 부분 --%>
 <tr><td colspan="5">
  <div class="w3-center w3-padding-32">
    <div class="w3-bar">
     <c:if test="${pageNum > 1}">
       <a href="list?pageNum=${pageNum - 1}&boardid=${boardid}">[이전]</a></c:if>
       <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage }" end="${endpage}">
         <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
         <c:if test="${a != pageNum}">
           <a class="w3-button w3-hover-black" 
              href="list?pageNum=${a}&boardid=${boardid}">${a}</a></c:if>
     </c:forEach>
     <c:if test="${pageNum < maxpage}">
           <a href="list?pageNum=${pageNum + 1}&boardid=${boardid}">[다음]</a></c:if>
     <c:if test="${pageNum >= maxpage}">[다음]</c:if></td></tr>
    </div>
  </div>
</c:if>
<c:if test="${listcount == 0}">
     <tr><td colspan="5">등록된 게시물이 없습니다.</td></tr>
 </c:if>
 
 
 
 <%--▶boardid==1(공지사항) 인 경우 관리자로 로그인 한 경우만 글쓰기 부분 출력하기 --%>
   <c:if test="${!empty param.boardid && param.boardid != '1'}">
    <tr><td colspan="5" align="right"><a href="write">[글쓰기]</a></td></tr>
   </c:if> 
        
   <c:if test="${empty param.boardid || param.boardid == '1'}">
     <c:if test="${loginUser.userid == 'admin' }">
     <tr><td colspan="5" align="right"><a href="write">[글쓰기]</a></td></tr>
     </c:if>
   </c:if>      
</table>



</body>
</html>