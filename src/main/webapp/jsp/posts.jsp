<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenDrafts — Posts</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root{
    --paper:#FAF8F4;
    --ink:#232323;
    --ink-soft:#6B6459;
    --accent:#A8471F;
    --line:#E4DFD3;
    --white:#FFFFFF;
  }
  *{box-sizing:border-box; margin:0; padding:0;}
  body{background:var(--paper); color:var(--ink); font-family:'Inter', sans-serif; line-height:1.6;}
  a{color:inherit; text-decoration:none;}
  .wrap{max-width:760px; margin:0 auto; padding:60px 24px;}
  h1{font-family:'Fraunces', serif; font-size:2.2rem; margin-bottom:8px;}
  .sub{color:var(--ink-soft); margin-bottom:40px;}
  .new-btn{display:inline-block; margin-bottom:32px; padding:10px 18px; background:var(--accent); color:var(--white); border-radius:6px; font-weight:600;}
  .post-card{border-bottom:1px solid var(--line); padding:24px 0;}
  <c:if test="${not empty post.imageUrl}">
  <img src="${post.imageUrl}" alt="${post.title}" ...>
  </c:if>
  .post-title{font-family:'Fraunces', serif; font-size:1.4rem; margin-bottom:6px;}
  .post-meta{color:var(--ink-soft); font-size:0.9rem; margin-bottom:10px;}
  .post-excerpt{color:var(--ink-soft);}
  .empty{color:var(--ink-soft); padding:40px 0;}
</style>
</head>
<body>
<div class="wrap">
  <h1>All Posts</h1>
  <p class="sub">Thoughts, drafts, and everything in between.</p>

  <c:if test="${sessionScope.isAdmin}">
  	<a class="new-btn" href="${pageContext.request.contextPath}/posts/new">+ Write a new post</a>
  </c:if>

  <c:choose>
    <c:when test="${empty posts}">
      <p class="empty">No posts yet. Be the first to write one.</p>
    </c:when>
    <c:otherwise>
      <c:forEach var="post" items="${posts}">
        <div class="post-card">
          <div class="post-title">
            <a href="${pageContext.request.contextPath}/posts/${post.id}">${post.title}</a>
          </div>
          <div class="post-meta">by ${post.author}</div>
          <div class="post-excerpt">
            <c:out value="${post.content.length() > 150 ? post.content.substring(0,150).concat('...') : post.content}" />
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>