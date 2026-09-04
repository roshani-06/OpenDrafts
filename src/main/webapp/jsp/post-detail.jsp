<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenDrafts — ${post.title}</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root{
    --paper:#FAF8F4; --ink:#232323; --ink-soft:#6B6459; --accent:#A8471F; --line:#E4DFD3; --white:#FFFFFF;
  }
  *{box-sizing:border-box; margin:0; padding:0;}
  body{background:var(--paper); color:var(--ink); font-family:'Inter', sans-serif; line-height:1.7;}
  a{color:var(--accent); text-decoration:none;}
  .wrap{max-width:700px; margin:0 auto; padding:60px 24px;}
  .back{display:inline-block; margin-bottom:32px; color:var(--ink-soft);}
  h1{font-family:'Fraunces', serif; font-size:2rem; margin-bottom:8px;}
  .meta{color:var(--ink-soft); margin-bottom:32px; font-size:0.95rem;}
  .content{white-space:pre-wrap; font-size:1.05rem;}
</style>
</head>
<body>
<div class="wrap">
  <h1>${post.title}</h1>
  <c:if test="${not empty post.imageUrl}">
  <img src="${post.imageUrl}" alt="${post.title}" ...>
  </c:if>
  <div class="meta">by ${post.author}</div>
  <div class="content">${post.content}</div>
  <hr style="margin:32px 0; border:none; border-top:1px solid var(--line);">

<c:if test="${not empty error}">
  <p style="color:#A8471F; font-weight:600; margin-bottom:12px;">${error}</p>
</c:if>

<c:if test="${sessionScope.isAdmin}">
  <hr style="margin:32px 0; border:none; border-top:1px solid var(--line);">

  <a href="${pageContext.request.contextPath}/posts/edit/${post.id}" style="display:inline-block; margin-bottom:16px; padding:8px 16px; background:var(--ink); color:#fff; border-radius:6px;">
    Edit Post
  </a>

  <form action="${pageContext.request.contextPath}/posts/delete/${post.id}" method="post">
    <button type="submit" style="padding:8px 16px; background:#A8471F; color:#fff; border:none; border-radius:6px; cursor:pointer;">
      Delete Post
    </button>
  </form>
</c:if>
</div>
</body>
</html>