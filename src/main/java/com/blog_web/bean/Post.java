package com.blog_web.bean;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "post")

public class Post {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY )
	private long id;
	
	@Column(nullable = false, length = 200)
    private String title;
	
	@Column(nullable = false, length = 100)
    private String author;
	
	@Column(nullable = false, columnDefinition = "LONGTEXT")
	private String content;
	
	@Column(name = "created_at")
    private LocalDateTime createdAt;
	
	@Column(name = "image_url")
	private String imageUrl;
	
	public Post(){	 
	}
	
	@PrePersist
	protected void onCreate() {
        this.createdAt = LocalDateTime.now();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	public String getFormattedDate() {
	    if (createdAt == null) return "";
	    return createdAt.format(java.time.format.DateTimeFormatter.ofPattern("MMMM d, yyyy"));
	}
	}
