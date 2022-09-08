<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- /WEB-INF/view/user/idsearch.jsp --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8">
<title>아이디찾기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
<div class="w3-content" style="max-width:700px">
	<h3 class="w3-center w3-padding-64"><span class="w3-tag w3-wide">아이디찾기</span></h3>
</div>
<form:form  modelAttribute="user" action="idsearch" method="post" style="width: 70%; margin: 0 auto;">
  <spring:hasBindErrors name="user">
    <font color="red"><c:forEach items="${errors.globalErrors}" var="error">
         <spring:message code="${error.code}" />
      </c:forEach></font>
  </spring:hasBindErrors>
      
 <p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="이메일" path="email" /></p>
 	<font color="red"><form:errors path="email" /></font>
 <br>
 <p><form:input class="w3-input w3-padding-16 w3-border" type="text" placeholder="전화번호" path="tel" /></p>
 	<font color="red"><form:errors path="tel" /></font>
 <br>
 <p style="text-align: center;">
    <input class="w3-button w3-black" type="submit" value="아이디찾기">
 </p>


</form:form>
</body>
</html>