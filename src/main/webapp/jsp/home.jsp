<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenDrafts — Home</title>
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

  body{
    background:var(--paper);
    color:var(--ink);
    font-family:'Inter', sans-serif;
    line-height:1.6;
  }

  a{color:inherit; text-decoration:none;}
  img{max-width:100%; display:block;}

  .wrap{
    max-width:840px;
    margin:0 auto;
    padding:0 24px;
  }

  /* HEADER */
  header{
    border-bottom:2px solid var(--ink);
    padding:22px 0;
  }
  header .wrap{
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:20px;
    flex-wrap:wrap;
  }
  .logo{
    font-family:'Fraunces', serif;
    font-weight:700;
    font-size:26px;
  }
  .logo span{color:var(--accent);}

  nav{
    display:flex;
    align-items:center;
    gap:26px;
  }
  nav a{
    font-size:14.5px;
    font-weight:500;
    color:var(--ink-soft);
    transition:color .15s ease;
  }
  nav a:hover, nav a.active{color:var(--accent);}

  /* INTRO */
  .intro{
    padding:56px 0 40px;
    border-bottom:1px solid var(--line);
  }
  .intro h1{
    font-family:'Fraunces', serif;
    font-size:clamp(30px, 5vw, 42px);
    font-weight:600;
    margin-bottom:14px;
    line-height:1.15;
  }
  .intro p{
    font-size:15.5px;
    color:var(--ink-soft);
    max-width:56ch;
  }

  /* POST LIST */
  .posts{
    padding:44px 0;
  }
  .post{
    display:flex;
    gap:24px;
    padding:28px 0;
    border-bottom:1px solid var(--line);
  }
  .post:first-child{padding-top:0;}
  .post:last-child{border-bottom:none;}
  .post-thumb{
    width:130px;
    height:100px;
    border-radius:6px;
    flex-shrink:0;
  }
  .post-thumb.t1{background:linear-gradient(150deg,#D9A76A,var(--accent));}
  .post-thumb.t2{background:linear-gradient(150deg,#8FA37E,#4E6B4A);}
  .post-thumb.t3{background:linear-gradient(150deg,#9AAEC4,#4E6E8A);}
  .post-thumb.t4{background:linear-gradient(150deg,#C48FA9,#8A4E6E);}

  .post-body{flex:1;}
  .post-date{
    font-size:12px;
    color:var(--ink-soft);
    margin-bottom:6px;
    letter-spacing:.02em;
  }
  .post h2{
    font-family:'Fraunces', serif;
    font-size:20px;
    font-weight:600;
    margin-bottom:8px;
    line-height:1.3;
  }
  .post h2 a:hover{color:var(--accent);}
  .post p{
    font-size:14px;
    color:var(--ink-soft);
    margin-bottom:8px;
  }
  .read-more{
    font-size:13px;
    font-weight:600;
    color:var(--accent);
  }
  .read-more:hover{text-decoration:underline;}

  /* FOOTER */
  footer{
    border-top:2px solid var(--ink);
    padding:26px 0;
    text-align:center;
  }
  footer p{
    font-size:13px;
    color:var(--ink-soft);
  }

  /* RESPONSIVE */
  @media (max-width:600px){
    header .wrap{flex-direction:column; align-items:flex-start;}
    nav{flex-wrap:wrap; gap:16px;}
    .post{flex-direction:column;}
    .post-thumb{width:100%; height:160px;}
  }

  @media (prefers-reduced-motion: reduce){
    *{transition:none !important;}
  }
</style>
</head>
<body>

  <header>
    <div class="wrap">
      <div class="logo">Open<span>Drafts</span></div>
      <nav>
        <a href="home" class="active">Home</a>
        
        <a href="aboutus">About</a>
        <a href="contact">Contact</a>
        <c:choose>
 		 	<c:when test="${sessionScope.isAdmin}">
    			<a href="${pageContext.request.contextPath}/admin/logout">Logout</a>
  		 	</c:when>
  			<c:otherwise>
    			<a href="${pageContext.request.contextPath}/admin/login">Admin</a>
 			</c:otherwise>
		</c:choose>
      </nav>
    </div>
  </header>

  <main class="wrap">

    <section class="intro">
      <h1>Thoughts, notes and things I'm learning</h1>
      <p>A simple space where I write about whatever's on my mind — no fixed schedule, just posts whenever I have something worth sharing.</p>
    </section>

<section class="posts">
  <c:choose>
    <c:when test="${empty posts}">
      <p>No posts yet. Check back soon.</p>
    </c:when>
    <c:otherwise>
      <c:forEach var="post" items="${posts}" varStatus="status" end="3">
        <article class="post">
          <div class="post-thumb t${(status.index % 4) + 1}">
  			<c:if test="${not empty post.imageUrl}">
    		<img src="${post.imageUrl}" alt="${post.title}" style="width:100%; border-radius:8px; margin:20px 0;">
  			</c:if>
		  </div>
          <div class="post-body">
            <div class="post-date">${post.formattedDate}</div>
            <h2><a href="${pageContext.request.contextPath}/posts/${post.id}">${post.title}</a></h2>
            <p>
              <c:out value="${post.content.length() > 120 ? post.content.substring(0,120).concat('...') : post.content}" />
            </p>
            <a href="${pageContext.request.contextPath}/posts/${post.id}" class="read-more">Read more →</a>
          </div>
        </article>
      </c:forEach>
    </c:otherwise>
  </c:choose>
</section>

  </main>

  <footer>
    <p>© 2026 OpenDrafts By Roshani Jaigude</p>
  </footer>

</body>
</html>