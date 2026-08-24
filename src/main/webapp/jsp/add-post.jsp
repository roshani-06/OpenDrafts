<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenDrafts — <c:choose><c:when test="${not empty post}">Edit Post</c:when><c:otherwise>New Post</c:otherwise></c:choose></title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<style>
  :root{
    --paper:#FAF8F4; --ink:#232323; --ink-soft:#6B6459; --accent:#A8471F; --line:#E4DFD3; --white:#FFFFFF;
  }
  *{box-sizing:border-box; margin:0; padding:0;}
  body{background:var(--paper); color:var(--ink); font-family:'Inter', sans-serif;}
  .wrap{max-width:600px; margin:0 auto; padding:60px 24px;}
  h1{font-family:'Fraunces', serif; font-size:1.8rem; margin-bottom:32px;}
  label{display:block; font-weight:600; margin-bottom:6px; margin-top:20px;}
  input, textarea{width:100%; padding:12px; border:1px solid var(--line); border-radius:6px; font-family:'Inter', sans-serif; font-size:1rem; background:var(--white);}
  textarea{min-height:220px; resize:vertical;}
  button{margin-top:28px; padding:12px 24px; background:var(--accent); color:var(--white); border:none; border-radius:6px; font-weight:600; font-size:1rem; cursor:pointer;}
  .current-img{width:150px; border-radius:6px; margin-top:8px; display:block;}
  .paste-hint{padding:14px; background:#fff; border:1px solid var(--line); border-radius:8px; margin-top:20px;}
  .paste-hint p{color:var(--ink-soft); font-size:0.85rem;}
  #upload-status{margin-top:6px;}
</style>
</head>
<body>
<div class="wrap">
  <h1><c:choose><c:when test="${not empty post}">Edit Post</c:when><c:otherwise>Write a New Post</c:otherwise></c:choose></h1>

  <c:if test="${not empty error}">
    <p style="color:#A8471F; font-weight:600; margin-bottom:16px;">${error}</p>
  </c:if>

  <c:choose>
    <c:when test="${not empty post}">
      <form action="${pageContext.request.contextPath}/posts/update/${post.id}" method="post" enctype="multipart/form-data">
    </c:when>
    <c:otherwise>
      <form action="${pageContext.request.contextPath}/posts/save" method="post" enctype="multipart/form-data">
    </c:otherwise>
  </c:choose>

    <label for="title">Title</label>
    <input type="text" id="title" name="title" value="${post.title}" required>

    <label for="author">Your Name</label>
    <input type="text" id="author" name="author" value="${post.author}" required>

    <label for="content">Content</label>
    <div style="margin-bottom:6px;">
  		<button type="button" onmousedown="event.preventDefault()" onclick="wrapSelection('strong')" style="padding:6px 12px; font-weight:700; margin-top:0; width:auto; display:inline-block;">B</button>
  		<button type="button" onmousedown="event.preventDefault()" onclick="wrapSelection('em')" style="padding:6px 12px; font-style:italic; margin-top:0; width:auto; display:inline-block; margin-left:6px;">I</button>
	</div>
    <textarea id="content" name="content" required>${post.content}</textarea>

    <label for="image">Blog Image <c:if test="${not empty post}">(leave empty to keep current image)</c:if></label>
    <c:if test="${not empty post.imageUrl}">
      <img class="current-img" src="${pageContext.request.contextPath}${post.imageUrl}" alt="Current image">
    </c:if>
    <input type="file" id="image" name="image" accept="image/*">

    <button type="submit"><c:choose><c:when test="${not empty post}">Update</c:when><c:otherwise>Publish</c:otherwise></c:choose></button>
  </form>

  <div class="paste-hint">
    <p>💡 Copy any image (a screenshot, or a copied file) and press Ctrl+V directly inside the content box above, wherever you want it to appear.</p>
    <p id="upload-status"></p>
  </div>

 <script>
  function wrapSelection(tag) {
	  const textarea = document.getElementById('content');
	  const start = textarea.selectionStart;
	  const end = textarea.selectionEnd;
	  const selectedText = textarea.value.substring(start, end);

	  if (selectedText.length === 0) {
	    alert('Select some text first, then click Bold or Italic.');
	    return;
	  }

	  const before = textarea.value.substring(0, start);
	  const after = textarea.value.substring(end);
	  const wrapped = '<' + tag + '>' + selectedText + '</' + tag + '>';

	  textarea.value = before + wrapped + after;
	  textarea.focus();
	}
  document.getElementById('content').addEventListener('paste', async function(event) {
    const items = event.clipboardData.items;
    const status = document.getElementById('upload-status');

    for (let item of items) {
      if (item.type.indexOf('image') !== -1) {
        event.preventDefault();

        const file = item.getAsFile();
        const formData = new FormData();
        formData.append('image', file);

        status.textContent = 'Uploading pasted image...';

        try {
          const response = await fetch('${pageContext.request.contextPath}/posts/upload-content-image', {
            method: 'POST',
            body: formData
          });
          const tag = await response.text();

          const textarea = document.getElementById('content');
          const cursorPos = textarea.selectionStart;
          const before = textarea.value.substring(0, cursorPos);
          const after = textarea.value.substring(cursorPos);
          textarea.value = before + '\n' + tag + '\n' + after;

          status.textContent = 'Image pasted and inserted!';
        } catch (err) {
          status.textContent = 'Paste upload failed. Try again.';
        }
        break;
      }
    }
  });
  </script>
</div>
</body>
</html>