<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="search">
	<input type="text" name="keyword" value="keyword" />
	<input type="submit" value="검색"/> 
</form>


	${search.board_content }
	
		
</body>
</html>