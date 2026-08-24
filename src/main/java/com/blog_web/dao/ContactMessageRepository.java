package com.blog_web.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.blog_web.bean.ContactMessage;

public interface ContactMessageRepository extends JpaRepository<ContactMessage, Long>{
	List<ContactMessage> findAllByOrderByCreatedAtDesc();
}
