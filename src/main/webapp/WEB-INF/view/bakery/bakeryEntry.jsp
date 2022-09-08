<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}"/><%-- /springmvc2 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>빵집 정보 등록</title>
<style type="text/css">
</style>
<script type="text/javascript">
function idChk(id) {
	let result = document.querySelector("#result")
	//id.length : 입력된 userid의 길이
	if((id.length < 3) || (id.length > 10)) {
		result.style.color = 'red'
		result.innerHTML="id는 3자리 이상 10자리 이하입니다."
	} else { //3자 이상 10자 이하인 경우
		$.ajax({
			url : "${path}/ajax/bakeryidchk",
			data : "bakeryid=" + id,
			success : function(chk){
				if(chk.trim() == 'false'){
					result.style.color='blue'
					result.innerHTML="사용 가능한 id 입니다."
				} else {
					result.style.color='red'
					result.innerHTML=" 사용 중 인 id 입니다."
				}
			}
		})		
	}
}

</script>
</head>
<body>
<div class="w3-content" style="max-width:700px">
    <h5 class="w3-center w3-padding-64"><span class="w3-tag w3-wide">${loginUser.name }님 빵집 등록</span></h5>
</div> 
<form:form modelAttribute="bakery" method="post" enctype="multipart/form-data" action="bakeryEntry" style="width: 70%; margin: 0 auto;">
	<span id="result"></span>
	<%-- global 오류 화면 출력 부분 --%>
	<spring:hasBindErrors name="bakery">
		<font color="red">
			 <c:forEach items="${errors.globalErrors }"	var="error">
					<spring:message code="${error.code }" />
			 </c:forEach>
		</font>
	</spring:hasBindErrors>
	<input type="hidden" name="userid" value=${param.userid }>
	
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="아이디" path="bakeryid"  onkeyup="idChk(this.value)"/></p>
	 		<font color="red"><form:errors path="bakeryid" /></font>
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="빵집 이름" path="bname"/></p>
	 		<font color="red"><form:errors path="bname" /></font>
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="위치" path="location"/></p>
	 		<font color="red"><form:errors path="location" /></font>
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="오픈시간" path="opentime"/></p>
	 		<font color="red"><form:errors path="opentime" /></font>
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="마감시간" path="closetime"/></p>
	 		<font color="red"><form:errors path="closetime" /></font>
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="휴무일" path="dayoff"/></p>
	 		<font color="red"><form:errors path="dayoff" /></font>
	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="전화번호" path="bakerytel"/></p>
	 		<font color="red"><form:errors path="bakerytel" /></font>
	<p>대표이미지 : <input type="file" name="bakeryimg"></p>
	<p><form:textarea class="w3-input w3-padding-16 w3-border"  rows="15" cols="40" placeholder="빵집 정보" path="bakeryinfo"/></p>
	    <font color="red"><form:errors path="bakeryinfo" /></font>
    
    
    <p></p>
    <hr style="border-top: 1px solid black">
    <div id="menu" name="menu">
    	<h4 style="text-align:center">[대표메뉴1]</h4>
    	<p><input class="w3-input w3-padding-16 w3-border" type="text" placeholder="대표메뉴이름" name="menuname" /></p>
    	<p>대표메뉴이미지 : <input type="file" name="menuimg"></p>
    	<p><input class="w3-input w3-padding-16 w3-border" placeholder="대표메뉴정보" name="menuinfo"/></p>
    </div>
    <input class="w3-button w3-black" name="add" style="width:100%" type="button" value="메뉴추가(3개까지 추가 가능)" id="addbtn">
    
     <script>
	    	$(function(){
	    		let cnt = 2;
	    		$("#addbtn").click(function(){
	    			if(cnt<=3){
		    			$("#menu").append('<h4 style="text-align:center">[대표메뉴'+ cnt +']</h4>')
		    			$("#menu").append('<p><input class="w3-input w3-padding-16 w3-border" type="text" placeholder="대표메뉴이름" name="menuname" /></p>');
		    			$("#menu").append('<p>대표메뉴이미지 : <input type="file" name="menuimg"></p>');
		    			$("#menu").append('<p><input class="w3-input w3-padding-16 w3-border" placeholder="대표메뉴정보" name="menuinfo"/></p>')
		    			cnt++;
	    			}
	    			else{
	    				alert("메뉴는 3개이상 추가할 수 없습니다");
	    			}
	    		})
	    	})
	   </script>
    
	<p style="text-align: center;">
    	<input class="w3-button w3-black" type="submit" value="정보 등록">
		<input class="w3-button w3-black" type="reset" value="초기화">
 	</p>
</form:form>

</body>
</html>