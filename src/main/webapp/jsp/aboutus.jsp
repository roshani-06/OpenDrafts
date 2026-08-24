<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenDrafts — About</title>
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

  /* PAGE (About / Contact) */
  .page{
    padding:56px 0 70px;
  }
  .page h1{
    font-family:'Fraunces', serif;
    font-size:clamp(28px, 4.5vw, 38px);
    font-weight:600;
    margin-bottom:18px;
  }
  .page > .wrap > p{
    font-size:15.5px;
    color:var(--ink-soft);
    max-width:58ch;
    margin-bottom:16px;
  }

  .about-block{
    display:flex;
    gap:28px;
    align-items:flex-start;
    margin-top:30px;
    flex-wrap:wrap;
  }
  .about-photo{
    width:150px;
    height:150px;
    border-radius:50%;
    overflow:hidden;
    flex-shrink:0;
  }
  .about-photo img{
    width:100%;
    height:100%;
    object-fit:cover;
  }
  .about-text{flex:1; min-width:240px;}
  .about-text p{
    font-size:14.5px;
    color:var(--ink-soft);
    margin-bottom:12px;
  }

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
    .about-block{flex-direction:column; align-items:center; text-align:center;}
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
        <a href="home">Home</a>
        
        <a href="aboutus" class="active">About</a>
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

  <main>
    <section class="page">
      <div class="wrap">
        <h1>About Us</h1>
        <p>A little bit about who's behind this blog and why it exists.</p>

        <div class="about-block">
          <div class="about-photo">
  			<img src="${pageContext.request.contextPath}/images/roshani_photo.jpeg" alt="Roshani Jaigude">
		  </div>
          <div class="about-text">
            <p>Hi, I'm <strong>Roshani Jaigude</strong> the person behind this blog. I write here occasionally — whenever something's worth putting into words. This isn't a daily journal, more like a quiet corner where I share things I'm learning, thinking about, or working on.</p>
            <p>I started this space to keep a record of ideas I didn't want to lose, and to share a few of them with anyone who happens to stop by. No pressure, no publishing calendar — just honest posts when I have something to say.</p>
            <p>Thanks for reading. If you ever want to say hello, the <a href="contact" style="color:var(--accent); font-weight:600;">contact page</a> is the best way to reach me.</p>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer>
    <p>© 2026 OpenDrafts By Roshani Jaigude</p>
  </footer>

</body>
</html>