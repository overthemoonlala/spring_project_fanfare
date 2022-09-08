<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
<script src="https://ajax.gooleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<style type="text/css">
table{width:100%}
table, th, td{ border: 1px solid w3-light-grey; border-collapse:collapse;}
.menuimg{width:100px;}
</style>
<script type="text/javascript">

/* like실행 */
 $(document).ready(function(){
	 let likeno = document.getElementById('likeno');
	 let likestate = document.getElementById('likestate').value;
	 const bakeryid = '${likebakery.bakeryid}';
	 const userid = "${sessionScope.userid}";
	 const likeimg = document.getElementById("likeimg");
	 
	 if(likeval > 0){
		 likeimg.src = "../img/하트.png";
	 }else{
		 likeimg.src = "../img/빈하트.png";
	 }
	 //좋아요 버튼을 클릭하면 실행
 $(".likeimg").on("click", function(){
	 $.ajax({
		 url: '/store/bakeryinfo',
		 type: 'POST',
		 data: {'bakeryid' : bakeryid, 'userid' : userid},
		 success: function(data) {
			 if(data == 1){
				 $("#likeimg").attr("src","../../하트.png");
				 location.reload();
			 } else {
				 $("#likeimg").attr("src","../../빈하트.png");
				 location.reload();
			 }
		 },error: function(){
			 $("#likeimg").attr("src","../../img/빈하트.png");
			 console.log("오류발생")
		 }
	 });
 }); 	 
 });
 
</script>
</head>
<body>
<div class="w3-content" style="max-width:700px">
    <h5 class="w3-center w3-padding-64"><span class="w3-tag w3-wide">Detail Page</span>
    <br><br>${bakery.bname}</h5>
    
    <!-- 좋아요 -->
    <div class="w3-right" align="right">
    <c:if test="${empty likeBakery}">
     <img id="likeimg" src="../img/빈하트.png" width="60px" height="60px" >
     ${likeBakery.likeno}<br>
     <p style="font-size: 11px;">좋아요는 로그인 후 사용 가능합니다.</p>
    </c:if>
    <c:if test="${!empty likeBakery}">
    <div>
     <input type="hidden" id="likestate" value="${likeBakery.likestate}">
     <img id="likeimg" src="../img/빈하트.png" width="60px" height="60px">
     ${likeBakery.likeno}
    </div></c:if>
    </div>
    
    <!-- img -->
    <div class="w3-center">
    	<img class="bakeryimg" src="../bakery/file/${bakery.fileurl }" style="width:100%;">
    </div>
    <br>
    <!-- info -->     
    <div style="display: block;">
      <table border="1">
        <tr>
          <th>주소</th><td>${bakery.location}</td>
          <th>휴무일</th><td>${bakery.dayoff}</td>
        </tr>
        <tr>
          <th>영업시간</th>
          <td>${bakery.opentime}~${bakery.closetime}</td>
          <th>대표번호</th><td>${bakery.bakerytel}</td>
        </tr>
         </table>
        
        <br>
        <h5 class="w3-center">대표메뉴</h5>
        <div class="w3-center" style="display: block; width: 100% " >
	        <c:forEach items="${bakerymenu}" var="menu">
		        <div style="width:32%; float:left; margin-right:3px;">
			        <table border="1">
				        <c:if test="${menu.menuid == 1}">
					         <tr><td>${menu.menuname}</td></tr>
					         <tr><td><img class="menuimg" src="../bakery/menu/file/${menu.menufileurl }"></td></tr>
					         <tr><td>${menu.menuinfo}</td></tr>
				        </c:if>
			        </table>
			    </div>
		        
		        <div style="width:32%; float:left; margin-right:5px;" >
			        <table border="1">
				        <c:if test="${menu.menuid == 2}">
					         <tr><td>${menu.menuname}</td></tr>
					         <tr><td><img class="menuimg" src="../bakery/menu/file/${menu.menufileurl }"></td></tr>
					         <tr><td>${menu.menuinfo}</td></tr>
				        </c:if>
			        </table>
			    </div>
		        
		        <div style="width:32%; float:right; margin-right:3px;">
			        <table border="1">
				        <c:if test="${menu.menuid == 3}">
					         <tr><td>${menu.menuname}</td></tr>
					         <tr><td><img class="menuimg" src="../bakery/menu/file/${menu.menufileurl }"></td></tr>
					         <tr><td>${menu.menuinfo}</td></tr>
				        </c:if>
			    	</table>
		        </div>
	        </c:forEach>
        </div>
        
      <div>
      	<a href="bakerylist?pageid=1">[BakeryList로 돌아가기]</a>
      </div>
      <br>
      
      <div class="w3-center w3-padding-large">
      	<button onclick="reservation"><a href="">예약하기</a></button>
      </div>
  </div> 
  <br>
  <!-- review write -->      
  <div class="w3-center w3-padding-large">
  <form:form modelAttribute="bakeryreview" action="review_write" enctype="multipart/form-data" name="f">
  <table border="1" style="font-size: 15px;">
  <caption>리뷰 쓰기</caption>
  <tr><th>제목</th><td><form:input path="subject" cols="100"/>
  <font color="red"><form:errors path="subject" /></font></td>
  <td colspan="2"><a href="javascript:document.f.submit()">[리뷰등록]</a></td></tr>
  <tr><th>작성자 id</th><td style="width: 30%; "><form:input path="userid" />
  <font color="red"><form:errors path="userid" /></font></td>
  <th style="width: 10%;">첨부파일</th><td style="width: 30%;" >
  <input type="file" name="file1" size="7"></td></tr>
  <tr><th colspan="1">내용</th><td colspan="3" style="width: 60%;" >
      <form:textarea  path="content" rows="5" cols="60"/>
      <font color="red"><form:errors path="content" /></font></td></tr>
  </table></form:form>
  </div>
  <br>
  
  <!-- review list-->
  <div class="w3-center w3-padding-large">
<table border="1"> <caption>bakery review</caption>
<c:if test="${rlistcount != null}">
	<tr><th style="width: 10%;">no</th><th style="width: 20%;">작성자</th>
	    <th style="width: 50%;">제목</th><th style="width: 20%;">작성시간</th></tr>
    <c:forEach var="bakeryreview" items="${bakeryreview_list}">
	    <tr><td>${bakeryreview.no}</td>
	        <td>${bakeryreview.userid}</td>
	        <td>
	          <details>
	            <summary>${bakeryreview.subject}</summary>
	            <p>${bakeryreview.content}</p>
	          </details>
	        </td>
	        <td>${bakeryreview.regdate}</td>
	    </tr>
	</c:forEach>
	<tr><td colspan="5">
   <div class="w3-center w3-padding-32">
    <div class="w3-bar">
     <c:if test="${pageNum > 1}">
      <a href="bakeryinfo?pageNum=${pageNum - 1}&bakeryid=${bakeryid}">[이전]</a></c:if>
      <c:if test="${pageNum <= 1}">[이전]</c:if>
     <c:forEach var="a" begin="${startpage}" end="${endpage}">
       <c:if test="${a == pageNum}"><a class="w3-button w3-black" href="#">${a}</a></c:if>
       <c:if test="${a != pageNum}">
        <a class="w3-button w3-hover-black"
           href="bakeryinfo?pageNum=${a}&bakeryid=${bakeryid}">${a}</a></c:if>
     </c:forEach>  
       <c:if test="${pageNum < maxpage}">
         <a href="bakeryinfo?pageNum=${pageNum + 1}&bakeryid=${bakeryid}">[다음]</a></c:if>
       <c:if test="${pageNum >= maxpage}">[다음]</c:if>
     </div></div></td></tr> 
  </c:if>
</table>
</div>    

</div>       
</body>
</html>