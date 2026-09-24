<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenDrafts — Contact</title>
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

  /* CONTACT FORM */
  .contact-form{
    margin-top:30px;
    max-width:480px;
    display:flex;
    flex-direction:column;
    gap:16px;
  }
  .contact-form label{
    font-size:13px;
    font-weight:600;
    margin-bottom:6px;
    display:block;
  }
  .contact-form input,
  .contact-form textarea{
    width:100%;
    border:1px solid var(--line);
    background:var(--white);
    border-radius:8px;
    padding:11px 14px;
    font-family:'Inter', sans-serif;
    font-size:14px;
    color:var(--ink);
    outline:none;
  }
  .contact-form input:focus,
  .contact-form textarea:focus{
    border-color:var(--accent);
  }
  .contact-form textarea{resize:vertical; min-height:110px;}
  .contact-form button{
    align-self:flex-start;
    border:none;
    background:var(--ink);
    color:var(--white);
    padding:12px 26px;
    border-radius:24px;
    font-family:'Inter', sans-serif;
    font-size:13.5px;
    font-weight:600;
    cursor:pointer;
    transition:background .15s ease;
  }
  .contact-form button:hover{background:var(--accent);}

  .contact-info{
    margin-top:34px;
    padding-top:24px;
    border-top:1px solid var(--line);
    display:flex;
    gap:40px;
    flex-wrap:wrap;
  }
  .contact-info div h3{
    font-size:12.5px;
    text-transform:uppercase;
    letter-spacing:.06em;
    color:var(--ink-soft);
    margin-bottom:6px;
  }
  .contact-info div p{
    font-size:14.5px;
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
        <a href="posts">Posts</a>
        <a href="aboutus">About</a>
        <a href="contact" class="active">Contact</a>
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
        <h1>Get in Touch</h1>
        <p>Have a question, a comment, or just want to say hi? Send a message below and I'll get back to you.</p>

        <!--
          For JSP: point the form action at your servlet/controller, e.g.
          <form class="contact-form" action="contact" method="post">
        -->
        <c:if test="${success}">
        	<p style="background:#DCEBD8; color:#2E5E33; padding:12px 16px; border-radius:6px; margin-bottom:20px; font-weight:600;">
        		Thanks for reaching out! Your message has been sent.
        	</p>
        </c:if>
        <form class="contact-form" action="contact" method="post">
          <div>
            <label for="name">Name</label>
            <input id="name" name="name" type="text" placeholder="Your name" required>
          </div>
          <div>
            <label for="email">Email</label>
            <input id="email" name="email" type="email" placeholder="you@example.com" required>
          </div>
          <div>
            <label for="message">Message</label>
            <textarea id="message" name="message" placeholder="Write your message here..." required></textarea>
          </div>
          <button type="submit">Send Message</button>
        </form>

        <div class="contact-info">
          <div>
            <h3>Email</h3>
            <p>roshanijaigude@gmail.com</p>
          </div>
          <div>
            <h3>Location</h3>
            <p>Maharashtra, India</p>
          </div>
          <div>
            <h3>Follow</h3>
            <p>Instagram - @roshhanii._</p>
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