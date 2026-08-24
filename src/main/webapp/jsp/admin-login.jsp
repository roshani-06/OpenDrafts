<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<style>
  :root{ --paper:#FAF8F4; --ink:#232323; --accent:#A8471F; --line:#E4DFD3; --white:#FFFFFF; }
  *{box-sizing:border-box; margin:0; padding:0;}
  body{background:var(--paper); color:var(--ink); font-family:'Inter', sans-serif; display:flex; align-items:center; justify-content:center; height:100vh;}
  .box{max-width:340px; width:100%; padding:32px; background:var(--white); border:1px solid var(--line); border-radius:8px;}
  h1{font-size:1.3rem; margin-bottom:20px;}
  input{width:100%; padding:12px; border:1px solid var(--line); border-radius:6px; margin-bottom:16px;}
  button{width:100%; padding:12px; background:var(--accent); color:#fff; border:none; border-radius:6px; font-weight:600; cursor:pointer;}
</style>
</head>
<body>
  <div class="box">
    <h1>Admin Login</h1>
    <c:if test="${not empty error}">
      <p style="color:var(--accent); margin-bottom:12px;">${error}</p>
    </c:if>
    <form action="${pageContext.request.contextPath}/admin/login" method="post">
      <input type="password" name="password" placeholder="Admin password" required>
      <button type="submit">Log In</button>
    </form>
  </div>
</body>
</html>