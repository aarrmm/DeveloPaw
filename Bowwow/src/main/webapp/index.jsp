<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
<h2>index</h2>

${sessionScope.userDTO.id}
<form action="/user/logout">
<input type="submit" value="logout">
</form>
</body>
</html>