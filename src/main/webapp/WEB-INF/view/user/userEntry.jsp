<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- /springmvc1/src/main/webapp/WEB-INF/view/user/userEntry.jsp --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="path" value="${pageContext.request.contextPath}"/><%-- /springmvc2 --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 등록</title>
<script type="text/javascript">
function idChk(id) {
	let result = document.querySelector("#result")
	//id.length : 입력된 userid의 길이
	if((id.length < 3) || (id.length > 10)) {
		result.style.color = 'red'
		result.innerHTML="id는 3자리 이상 10자리 이하입니다."
	} else { //3자 이상 10자 이하인 경우
		$.ajax({
			url : "${path}/ajax/idchk",
			data : "userid=" + id,
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
    <h5 class="w3-center w3-padding-64"><span class="w3-tag w3-wide">사용자 등록</span></h5>
</div> 
	
<form:form modelAttribute="user" method="post" action="userEntry" style="width: 70%; margin: 0 auto;">
	<span id="result"></span>
	<%-- global 오류 화면 출력 부분 --%>
		<spring:hasBindErrors name="user">
			<font color="red">
			<%-- ${errors.globalErrors} : Controller에서 BindingResult.reject()함수로 설정한 오류 코드들 --%>
			 <c:forEach items="${errors.globalErrors }"	var="error">
					<spring:message code="${error.code }" />
			 </c:forEach></font>
		</spring:hasBindErrors>
		
 	<p><input type="radio" name="type" value="0" checked>개인&nbsp;&nbsp;&nbsp;&nbsp;
 		<input type="radio" name="type" value="1">사장</p>

 	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="아이디" path="userid" onkeyup="idChk(this.value)" /></p>
 		<font color="red"><form:errors path="userid" /></font>
 
 	<p><form:input class="w3-input w3-padding-16 w3-border" type="password" placeholder="비밀번호" path="pass" /></p>
 		<font color="red"><form:errors path="pass" /></font>
 		
 	<p><form:input class="w3-input w3-padding-16 w3-border" type="password" placeholder="비밀번호확인" path="passCheck" /></p>
 		<font color="red"><form:errors path="passCheck" /></font>
 		
 	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="이름" path="name" /></p>
 		<font color="red"><form:errors path="name" /></font>

 	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="전화번호" path="tel" /></p>
 		<font color="red"><form:errors path="tel" /></font>

 	<p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="이메일" path="email" /></p>
 		<font color="red"><form:errors path="email" /></font>


	<p style="text-align: center;">
    	<input class="w3-button w3-black" type="submit" value="회원가입">
		<input class="w3-button w3-black" type="reset" value="초기화">
 	</p>

</form:form>
</body>
</html>