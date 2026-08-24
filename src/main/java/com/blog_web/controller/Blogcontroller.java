package com.blog_web.controller;

import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpSession;
import com.blog_web.bean.ContactMessage;
import com.blog_web.dao.ContactMessageRepository;

import org.springframework.beans.factory.annotation.Value;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.UUID;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog_web.bean.Post;
import com.blog_web.dao.PostRepository;

@Controller
public class Blogcontroller {

	@Autowired
	private PostRepository postRepository;
	@Autowired
	private ContactMessageRepository contactMessageRepository;

	@Value("${admin.password}")
    private String adminPassword;
	@Value("${file.upload-dir}")
	private String uploadDir;

	@RequestMapping("/")
    public String root() {
        return "redirect:/home";
    }

    @RequestMapping("/home")
    public String home(Model model) {
        List<Post> posts = postRepository.findAllByOrderByCreatedAtDesc();
        model.addAttribute("posts", posts);
        return "home";
    }

	@RequestMapping("/aboutus")
	public String aboutus() {
		return "aboutus";
	}

	@GetMapping("/contact")
	public String contact() {
	    return "contact";
	}

	@PostMapping("/contact")
	public String submitContact(@RequestParam String name,
	                             @RequestParam String email,
	                             @RequestParam String message,
	                             Model model) {

	    ContactMessage cm = new ContactMessage();
	    cm.setName(name);
	    cm.setEmail(email);
	    cm.setMessage(message);
	    contactMessageRepository.save(cm);

	    model.addAttribute("success", true);
	    return "contact";
	}

    @GetMapping("/posts")
    public String listPosts(Model model) {
        List<Post> posts = postRepository.findAllByOrderByCreatedAtDesc();
        model.addAttribute("posts", posts);
        return "posts";
    }

    @GetMapping("/posts/{id}")
    public String viewPost(@PathVariable Long id, Model model) {
        Post post = postRepository.findById(id).orElse(null);
        model.addAttribute("post", post);
        return "post-detail";
    }

    @GetMapping("/posts/new")
    public String newPostForm(HttpSession session) {
        if (session.getAttribute("isAdmin") == null) return "redirect:/admin/login";
        return "add-post";
    }

    @PostMapping("/posts/save")
    public String savePost(@RequestParam String title,
                            @RequestParam String author,
                            @RequestParam String content,
                            @RequestParam(value = "image", required = false) MultipartFile image,
                            HttpSession session,
                            Model model) throws Exception {

        if (session.getAttribute("isAdmin") == null) return "redirect:/admin/login";

        Post post = new Post();
        post.setTitle(title);
        post.setAuthor(author);
        post.setContent(content);

        if (image != null && !image.isEmpty()) {
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String filename = UUID.randomUUID() + "_" + image.getOriginalFilename();
            Path filepath = Path.of(uploadDir, filename);
            Files.write(filepath, image.getBytes());
            post.setImageUrl("/uploads/" + filename);
        }

        postRepository.save(post);
        return "redirect:/posts";
    }

    @PostMapping("/posts/delete/{id}")
    public String deletePost(@PathVariable Long id, HttpSession session) {
        if (session.getAttribute("isAdmin") == null) return "redirect:/admin/login";
        postRepository.deleteById(id);
        return "redirect:/posts";
    }

    @GetMapping("/posts/edit/{id}")
    public String editPostForm(@PathVariable Long id, HttpSession session, Model model) {
        if (session.getAttribute("isAdmin") == null) return "redirect:/admin/login";
        Post post = postRepository.findById(id).orElse(null);
        model.addAttribute("post", post);
        return "add-post";
    }

    @PostMapping("/posts/update/{id}")
    public String updatePost(@PathVariable Long id,
                              @RequestParam String title,
                              @RequestParam String author,
                              @RequestParam String content,
                              @RequestParam(value = "image", required = false) MultipartFile image,
                              HttpSession session,
                              Model model) throws Exception {

        if (session.getAttribute("isAdmin") == null) return "redirect:/admin/login";

        Post post = postRepository.findById(id).orElse(null);
        if (post == null) return "redirect:/posts";

        post.setTitle(title);
        post.setAuthor(author);
        post.setContent(content);

        if (image != null && !image.isEmpty()) {
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String filename = UUID.randomUUID() + "_" + image.getOriginalFilename();
            Path filepath = Path.of(uploadDir, filename);
            Files.write(filepath, image.getBytes());
            post.setImageUrl("/uploads/" + filename);
        }

        postRepository.save(post);
        return "redirect:/posts/" + id;
    }

    // NEW: handles paste-to-upload from the content textarea
    @PostMapping("/posts/upload-content-image")
    @ResponseBody
    public String uploadContentImage(@RequestParam("image") MultipartFile image, HttpSession session) throws Exception {
        if (session.getAttribute("isAdmin") == null) {
            return "Not logged in.";
        }

        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        String filename = UUID.randomUUID() + "_" + image.getOriginalFilename();
        Path filepath = Path.of(uploadDir, filename);
        Files.write(filepath, image.getBytes());

        return "<img src=\"/uploads/" + filename + "\" style=\"width:100%; border-radius:8px; margin:16px 0;\">";
    }

    @GetMapping("/admin/login")
    public String loginForm() {
        return "admin-login";
    }

    @PostMapping("/admin/login")
    public String login(@RequestParam String password, HttpSession session, Model model) {
        if (adminPassword.equals(password)) {
            session.setAttribute("isAdmin", true);
            return "redirect:/posts";
        }
        model.addAttribute("error", "Incorrect password.");
        return "admin-login";
    }

    @GetMapping("/admin/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/posts";
    }

}