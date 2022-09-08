<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/user/login.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8">

<title>로그인화면</title>
<script type="text/javascript">
function win_open(page) {
	   let op = "width=480, height=440, left=50,top=150";
	   open(page,"",op);
}
</script>
</head>
<body>
<div class="w3-content" style="max-width:700px">
    <h5 class="w3-center w3-padding-64"><span class="w3-tag w3-wide">로그인</span></h5>
</div>    
<form:form modelAttribute="user" method="post" action="login" name="loginform" style="width: 70%; margin: 0 auto;">
	<input type="hidden" name="name" value="유효성검증을위한 파라미터" >
	<input type="hidden" name="email" value="valid@aaa.bbb" >
	<input type="hidden" name="passCheck" value="vald1234" >
    <input type="hidden" name="tel" value="1234" >
  	<spring:hasBindErrors name="user">
    	<font color="red">
    	<c:forEach items="${errors.globalErrors}" var="error">
         	<spring:message code="${error.code}" />
      	</c:forEach>
    	</font>
    </spring:hasBindErrors>
 <br>
 <p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="아이디" path="userid" /></p>
 	<font color="red"><form:errors path="userid" /></font>
  <br>
 <p><form:input class="w3-input w3-padding-16 w3-border" type="password" placeholder="비밀번호" path="pass" /></p>
 	<font color="red"><form:errors path="pass" /></font>
  <br>	
 <p style="text-align: center;">
    <input class="w3-button w3-black" type="submit" value="로그인">
	<input class="w3-button w3-black" type="button" value="회원가입"  onclick="location.href='userEntry'">
	<input class="w3-button w3-black" type="button" value="아이디찾기" onclick="win_open('idsearch')">
    <input class="w3-button w3-black" type="button" value="비밀번호찾기" onclick="win_open('pwsearch')" >
 </p>


</form:form>
</body>
</html>